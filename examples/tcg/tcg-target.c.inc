#include "tcg-target.h"

/*
 * OMI TCG backend profile.
 *
 * This file mirrors QEMU's included-backend style and is intentionally not
 * compiled by Omino. It records the target constraints and instruction packing
 * profile used by the Section 44 architecture notes.
 */

static const int tcg_target_reg_alloc_order[] = {
    TCG_REG_R1, TCG_REG_R2, TCG_REG_R3, TCG_REG_R4,
    TCG_REG_R5, TCG_REG_R6, TCG_REG_R7, TCG_REG_R8,
    TCG_REG_R9, TCG_REG_R10, TCG_REG_R11, TCG_REG_R12
};

static const TCGConstraintSetIndex tcg_target_op_constraints(TCGOpcode op) {
    switch (op) {
    case INDEX_op_ld8u_i32:
    case INDEX_op_ld8s_i32:
    case INDEX_op_ld16u_i32:
    case INDEX_op_ld16s_i32:
    case INDEX_op_ld_i32:
    case INDEX_op_ld_i64:
        return C_O1_I1(r, r);

    case INDEX_op_st8_i32:
    case INDEX_op_st16_i32:
    case INDEX_op_st_i32:
    case INDEX_op_st_i64:
        return C_O0_I2(r, r);

    case INDEX_op_add_i64:
    case INDEX_op_sub_i64:
    case INDEX_op_xor_i64:
        return C_O1_I2(r, r, r);

    default:
        return C_NotImplemented;
    }
}

static inline void tcg_out_opc(TCGContext *s, uint16_t machine_ins) {
    *s->code_ptr++ = machine_ins;
}

static void tcg_out_op(TCGContext *s,
                       TCGOpcode opc,
                       const TCGArg *args,
                       const int *consts) {
    TCGReg ret = args[0];
    TCGReg arg1 = args[1];
    TCGReg arg2 = args[2];
    (void)consts;

    switch (opc) {
    case INDEX_op_mov_i64:
    case INDEX_op_mov_i32:
        if (ret != arg1) {
            tcg_out_opc(s, (uint16_t)((0x1u << 12) | (ret << 6) | arg1));
        }
        break;

    case INDEX_op_add_i64:
        tcg_out_opc(s, (uint16_t)((0xAu << 12) | (ret << 8) | (arg1 << 4) | arg2));
        break;

    case INDEX_op_st_i64: {
        intptr_t offset = args[2];
        TCGReg base = args[1];
        TCGReg src = args[0];

        if (offset < -2147483648LL || offset > 2147483647LL) {
            tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, offset);
            tcg_out_opc(s, (uint16_t)((0xAu << 12) | (TCG_REG_TMP << 8) |
                                      (TCG_REG_TMP << 4) | base));
            base = TCG_REG_TMP;
        }
        tcg_out_opc(s, (uint16_t)((0x5u << 12) | (src << 6) | base));
        break;
    }

    default:
        tcg_abort();
    }
}

static void tcg_out_ffi_call(TCGContext *s, const TCGHelperInfo *info) {
    (void)info;
    tcg_out_opc(s, 0xF800u);
}
