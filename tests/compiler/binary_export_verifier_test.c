#include <stdio.h>
#include "../../examples/compiler/binary_export_verifier.c"

static int fail(const char *message) {
    fprintf(stderr, "binary export conformance failed: %s\n", message);
    return 1;
}

int main(void) {
    BinaryExportImage centroid = meta_compile_to_eal(0u, 0u);
    BinaryExportImage void_form = meta_compile_to_first_form();
    BinaryExportImage active = meta_compile_to_eal(15u, 30u);
    BinaryExportImage altered = centroid;
    BinaryExportImage shortened = centroid;
    size_t mismatch_index = 0u;

    if (centroid.stream_length != 12u ||
        centroid.binary_data[0] != 0xF8u ||
        centroid.binary_data[7] != 0xF8u) {
        return fail("centroid export shape mismatch");
    }

    if (binary_export_compare(NULL, &void_form, NULL) != EXPORT_ERROR_INVALID_ARGUMENT) {
        return fail("NULL left image accepted");
    }
    if (binary_export_compare(&centroid, NULL, NULL) != EXPORT_ERROR_INVALID_ARGUMENT) {
        return fail("NULL right image accepted");
    }

    if (binary_export_compare(&centroid, &void_form, &mismatch_index) != EXPORT_OK ||
        mismatch_index != centroid.stream_length) {
        return fail("centroid and first form did not match");
    }

    if (active.binary_data[11] != 120u) {
        return fail("active linear-root byte mismatch");
    }
    if (binary_export_compare(&active, &void_form, NULL) != EXPORT_ERROR_HASH_MISMATCH) {
        return fail("active coordinate export matched first form");
    }

    altered.binary_data[3] ^= 0x01u;
    altered.signature_hash = centroid.signature_hash;
    if (binary_export_compare(&altered, &centroid, &mismatch_index) != EXPORT_ERROR_BYTE_MISMATCH ||
        mismatch_index != 3u) {
        return fail("byte mismatch not detected");
    }

    shortened.stream_length = 8u;
    shortened.signature_hash = export_fnv1a32(shortened.binary_data, shortened.stream_length);
    if (binary_export_compare(&shortened, &centroid, NULL) != EXPORT_ERROR_LENGTH_MISMATCH) {
        return fail("length mismatch not detected");
    }

    shortened.stream_length = OMI_EXPORT_BUFFER_MAX + 1u;
    if (binary_export_compare(&shortened, &centroid, NULL) != EXPORT_ERROR_INVALID_ARGUMENT) {
        return fail("oversized image accepted");
    }

    printf("Binary export conformance verified: examples/compiler/binary_export_verifier.c\n");
    return 0;
}
