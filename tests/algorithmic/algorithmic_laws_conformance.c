#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

static int fail(const char *message) {
    fprintf(stderr, "algorithmic law conformance failed: %s\n", message);
    return 1;
}

static uint32_t lambda_q(uint16_t x, uint16_t y) {
    uint32_t root = (((uint32_t)x) << 2) + (((uint32_t)y) << 1);
    return root * root;
}

static uint8_t octahedral_face(uint16_t address) {
    uint8_t row_nibble = (uint8_t)((address >> 12) & 0x0Fu);
    uint8_t col_nibble = (uint8_t)((address >> 4) & 0x0Fu);
    return (uint8_t)(((row_nibble >> 2) << 1) | (col_nibble >> 3));
}

static bool tetragrammatron_witness(uint32_t witness) {
    return witness == 30u || witness == 60u || witness == 120u;
}

static bool metatron_witness(uint32_t witness) {
    return witness == 24u || witness == 1u || witness == 16u ||
           witness == 256u || witness == 4096u || witness == 65536u;
}

static bool gnomonic_witness(uint32_t witness) {
    return witness == 0xAA55u || witness == 0x55AAu;
}

static uint8_t address_plane(uint8_t address) {
    if (address <= 0x1Fu) return 0u;
    if (address <= 0x7Fu) return 1u;
    if (address <= 0x9Fu) return 2u;
    return 3u;
}

static uint16_t metatron_step(uint16_t value, bool *carry) {
    uint32_t next = ((uint32_t)value) << 4;
    *carry = next > 0xFFFFu;
    return (uint16_t)(next & 0xFFFFu);
}

static uint32_t omnicron_bqf(uint32_t x, uint32_t y) {
    return (60u * x * x) + (16u * x * y) + (4u * y * y);
}

static uint8_t omnicron_byte_band(uint8_t b) {
    if (b <= 0x1Fu) return 0u;
    if (b <= 0x7Fu) return 1u;
    if (b <= 0xAFu) return 3u;
    return 2u;
}

static bool fano_slot(uint8_t fano7, uint8_t role3, uint8_t local240, uint16_t *out_slot) {
    if (fano7 > 6u || role3 > 2u || local240 > 239u) {
        *out_slot = 0u;
        return false;
    }
    *out_slot = (uint16_t)((fano7 * 720u) + (role3 * 240u) + local240);
    return true;
}

static bool meta_assemble(uint8_t opcode, uint16_t slot5040, uint8_t token, uint16_t *out_word) {
    if (slot5040 >= 5040u || token > 0x7Fu) {
        *out_word = 0u;
        return false;
    }
    *out_word = (uint16_t)(((uint16_t)(opcode & 0x0Fu) << 12) | (slot5040 & 0x0FFFu));
    return true;
}

static uint8_t backplane_fault(uint8_t local_azimuth,
                               uint8_t remote_azimuth,
                               uint16_t tetra_sum,
                               bool hamming_double_error) {
    if (hamming_double_error) return 3u;
    if (tetra_sum != 120u) return 2u;
    if ((uint8_t)(local_azimuth ^ remote_azimuth) != 0x80u) return 1u;
    return 0u;
}

static uint8_t layer4_weight(uint8_t nibble) {
    switch (nibble & 0x0Fu) {
    case 0x0u:
        return 0u;
    case 0x1u:
    case 0x7u:
    case 0xFu:
        return 1u;
    case 0x4u:
    case 0xAu:
    case 0xEu:
        return 6u;
    case 0xBu:
        return 12u;
    default:
        return 4u;
    }
}

static void visual_matrix(uint8_t nibble, uint8_t *row, uint8_t *col) {
    *row = (uint8_t)((nibble >> 2) & 0x03u);
    *col = (uint8_t)(nibble & 0x03u);
}

static void lagrange_unfold(uint8_t byte, uint8_t *band, uint8_t *slot) {
    *band = (uint8_t)((byte >> 5) & 0x03u);
    *slot = (uint8_t)(byte & 0x1Fu);
}

static bool lagrange_fold(uint8_t band, uint8_t slot, uint8_t *byte) {
    if (band > 3u || slot > 31u) return false;
    *byte = (uint8_t)((band << 5) | slot);
    return true;
}

static uint8_t h743_parity(uint8_t fs, uint8_t gs, uint8_t rs, uint8_t us) {
    uint8_t logos = (uint8_t)(fs ^ gs ^ us);
    uint8_t nomos = (uint8_t)(fs ^ rs ^ us);
    uint8_t pathos = (uint8_t)(gs ^ rs ^ us);
    return (uint8_t)((logos << 6) | (nomos << 5) | (fs << 4) |
                     (pathos << 3) | (gs << 2) | (rs << 1) | us);
}

static uint8_t miquel844_code(uint8_t fs, uint8_t gs, uint8_t rs, uint8_t us) {
    uint8_t compact = h743_parity(fs, gs, rs, us);
    uint8_t omnion = 0u;
    uint8_t temp = compact;
    for (uint8_t i = 0u; i < 7u; i++) {
        omnion ^= (uint8_t)(temp & 1u);
        temp = (uint8_t)(temp >> 1);
    }
    return (uint8_t)((compact << 1) | omnion);
}

int main(void) {
    uint16_t slot = 0u;
    uint16_t word = 0u;
    uint8_t row = 0u;
    uint8_t col = 0u;
    uint8_t band = 0u;
    uint8_t fold_slot = 0u;
    uint8_t byte = 0u;
    bool carry = false;

    if (lambda_q(15u, 30u) != 14400u) return fail("Lambda Canon Q mismatch");
    if (octahedral_face(0xA080u) != 5u) return fail("octahedral face mismatch");
    if (!tetragrammatron_witness(120u) || tetragrammatron_witness(24u)) {
        return fail("canonical Tetragrammatron namespace mismatch");
    }
    if (!metatron_witness(4096u) || metatron_witness(60u)) {
        return fail("canonical Metatron namespace mismatch");
    }
    if (!gnomonic_witness(0xAA55u) || gnomonic_witness(0x1Eu)) {
        return fail("canonical Gnomonic namespace mismatch");
    }
    if (address_plane(0x1Fu) != 0u || address_plane(0x48u) != 1u ||
        address_plane(0x80u) != 2u || address_plane(0xA0u) != 3u) {
        return fail("address plane mismatch");
    }

    if (metatron_step(0x0001u, &carry) != 0x0010u || carry) {
        return fail("Metatron FS->GS step mismatch");
    }
    if (metatron_step(0x1000u, &carry) != 0x0000u || !carry) {
        return fail("Metatron carry mismatch");
    }
    if (omnicron_bqf(15u, 4u) != 14524u) return fail("Omnicron BQF mismatch");
    if (omnicron_byte_band(0x1Fu) != 0u || omnicron_byte_band(0x3Fu) != 1u ||
        omnicron_byte_band(0x80u) != 3u || omnicron_byte_band(0xB0u) != 2u) {
        return fail("Omnicron byte band mismatch");
    }

    if (!fano_slot(6u, 2u, 239u, &slot) || slot != 5039u) {
        return fail("Fano slot ceiling mismatch");
    }
    if (fano_slot(7u, 0u, 0u, &slot) || slot != 0u) {
        return fail("Fano bounds mismatch");
    }
    if (!meta_assemble(0xAu, 1780u, 0x7Fu, &word) || word != 0xA6F4u) {
        return fail("meta-assembly mismatch");
    }
    if (meta_assemble(0xAu, 5040u, 0x7Fu, &word) || word != 0u) {
        return fail("meta-assembly bounds mismatch");
    }
    if (backplane_fault(0x00u, 0x80u, 120u, false) != 0u ||
        backplane_fault(0x00u, 0x00u, 120u, false) != 1u ||
        backplane_fault(0x00u, 0x80u, 119u, false) != 2u ||
        backplane_fault(0x00u, 0x80u, 120u, true) != 3u) {
        return fail("backplane interlock priority mismatch");
    }

    if (layer4_weight(0x0u) != 0u || layer4_weight(0xBu) != 12u ||
        layer4_weight(0xAu) != 6u || layer4_weight(0xCu) != 4u) {
        return fail("Layer-4 weight mismatch");
    }
    visual_matrix(0xBu, &row, &col);
    if (row != 2u || col != 3u) return fail("visual matrix mismatch");
    lagrange_unfold(0x75u, &band, &fold_slot);
    if (band != 3u || fold_slot != 21u) return fail("Lagrange unfold mismatch");
    if (!lagrange_fold(3u, 21u, &byte) || byte != 0x75u) {
        return fail("Lagrange fold mismatch");
    }
    if (lagrange_fold(4u, 0u, &byte)) return fail("Lagrange fold bounds mismatch");

    if (miquel844_code(1u, 0u, 1u, 1u) != 0x66u) {
        return fail("Miquel [8,4,4] extended parity mismatch");
    }

    printf("Algorithmic law conformance verified\n");
    return 0;
}
