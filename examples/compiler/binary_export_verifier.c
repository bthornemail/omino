#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <string.h>

#define OMI_EXPORT_BUFFER_MAX 64u

typedef enum {
    EXPORT_OK = 0,
    EXPORT_ERROR_INVALID_ARGUMENT,
    EXPORT_ERROR_LENGTH_MISMATCH,
    EXPORT_ERROR_BYTE_MISMATCH,
    EXPORT_ERROR_HASH_MISMATCH
} export_status;

typedef struct {
    uint8_t binary_data[OMI_EXPORT_BUFFER_MAX];
    size_t stream_length;
    uint32_t signature_hash;
} BinaryExportImage;

static uint32_t export_fnv1a32(const uint8_t *data, size_t len) {
    uint32_t hash = 2166136261u;

    for (size_t i = 0; i < len; i++) {
        hash ^= data[i];
        hash *= 16777619u;
    }

    return hash;
}

static BinaryExportImage meta_compile_to_eal(uint16_t x_omi, uint16_t y_imo) {
    BinaryExportImage img;
    uint32_t linear_root;

    memset(&img, 0, sizeof(img));

    img.binary_data[0] = 0xF8u;
    img.binary_data[1] = 0x00u;
    img.binary_data[2] = 0x1Cu;
    img.binary_data[3] = 0x1Du;
    img.binary_data[4] = 0x1Eu;
    img.binary_data[5] = 0x1Fu;
    img.binary_data[6] = 0x20u;
    img.binary_data[7] = 0xF8u;

    linear_root = (((uint32_t)x_omi) << 2) + (((uint32_t)y_imo) << 1);
    img.binary_data[8] = (uint8_t)((linear_root >> 24) & 0xFFu);
    img.binary_data[9] = (uint8_t)((linear_root >> 16) & 0xFFu);
    img.binary_data[10] = (uint8_t)((linear_root >> 8) & 0xFFu);
    img.binary_data[11] = (uint8_t)(linear_root & 0xFFu);

    img.stream_length = 12u;
    img.signature_hash = export_fnv1a32(img.binary_data, img.stream_length);
    return img;
}

static BinaryExportImage meta_compile_to_first_form(void) {
    return meta_compile_to_eal(0u, 0u);
}

static export_status binary_export_compare(const BinaryExportImage *a,
                                           const BinaryExportImage *b,
                                           size_t *out_mismatch_index) {
    if (a == NULL || b == NULL) return EXPORT_ERROR_INVALID_ARGUMENT;
    if (a->stream_length > OMI_EXPORT_BUFFER_MAX || b->stream_length > OMI_EXPORT_BUFFER_MAX) {
        return EXPORT_ERROR_INVALID_ARGUMENT;
    }
    if (a->stream_length != b->stream_length) return EXPORT_ERROR_LENGTH_MISMATCH;
    if (a->signature_hash != b->signature_hash) return EXPORT_ERROR_HASH_MISMATCH;

    for (size_t i = 0; i < a->stream_length; i++) {
        if (a->binary_data[i] != b->binary_data[i]) {
            if (out_mismatch_index != NULL) *out_mismatch_index = i;
            return EXPORT_ERROR_BYTE_MISMATCH;
        }
    }

    if (out_mismatch_index != NULL) *out_mismatch_index = a->stream_length;
    return EXPORT_OK;
}

#ifdef OMI_BINARY_EXPORT_EMULATED_MAIN
#include <stdio.h>

int main(void) {
    BinaryExportImage eal_centroid = meta_compile_to_eal(0u, 0u);
    BinaryExportImage void_form = meta_compile_to_first_form();
    BinaryExportImage eal_active = meta_compile_to_eal(15u, 30u);

    printf("--- OMI-IMO META-COMPILER: BINARY EXPORT VERIFICATION ---\n");
    printf("Centroid hash: 0x%08X\n", eal_centroid.signature_hash);
    printf("Void hash    : 0x%08X\n", void_form.signature_hash);
    printf("Active hash  : 0x%08X\n", eal_active.signature_hash);

    return binary_export_compare(&eal_centroid, &void_form, NULL) == EXPORT_OK ? 0 : 1;
}
#endif
