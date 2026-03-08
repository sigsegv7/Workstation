//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`ifndef CPU_REGS_SVH
`define CPU_REGS_SVH

//
// Valid processor registers
//
typedef enum logic [4:0] {
    REG_R0,
    REG_R1,
    REG_R2,
    REG_R3,
    REG_R4,
    REG_R5,
    REG_R6,
    REG_R7,
    REG_A0,
    REG_A1,
    REG_A2,
    REG_A3,
    REG_A4,
    REG_A5,
    REG_A6,
    REG_A7,
    REG_TT,
    REG_SP,
    REG_FP
} reg_t;

`endif  /* !CPU_REGS_SVH */
