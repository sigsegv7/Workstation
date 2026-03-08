//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "cpu/regs.svh"

//
// On-core register bank
//
// @clk_i:      Clock input
// @reset_i:    Reset input
// @regsel_i:   Register select input
// @regval_i:   Write value input
// @write_en_i: Register enable input
// @regval_o:   Register value output
//
module cpu_regbank #(
    parameter GP_RESET_VALUE = 64'hAAAAAAAAAAAAAAAA,
    parameter WORD_BITS = 64
) (
    input wire clk_i,
    input wire reset_i,
    input wire [4:0] regsel_i,
    input wire [WORD_BITS-1:0] regval_i,
    input wire write_en_i,

    output logic [WORD_BITS-1:0] regval_o
);
    logic [WORD_BITS-1:0] bank [0:18];

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            bank[REG_R0] <= GP_RESET_VALUE;
            bank[REG_R1] <= GP_RESET_VALUE;
            bank[REG_R2] <= GP_RESET_VALUE;
            bank[REG_R3] <= GP_RESET_VALUE;
            bank[REG_R4] <= GP_RESET_VALUE;
            bank[REG_R5] <= GP_RESET_VALUE;
            bank[REG_R6] <= GP_RESET_VALUE;
            bank[REG_R7] <= GP_RESET_VALUE;
            bank[REG_A0] <= GP_RESET_VALUE;
            bank[REG_A1] <= GP_RESET_VALUE;
            bank[REG_A2] <= GP_RESET_VALUE;
            bank[REG_A3] <= GP_RESET_VALUE;
            bank[REG_A4] <= GP_RESET_VALUE;
            bank[REG_A5] <= GP_RESET_VALUE;
            bank[REG_A6] <= GP_RESET_VALUE;
            bank[REG_A7] <= GP_RESET_VALUE;
            bank[REG_TT] <= 0;
            bank[REG_SP] <= 0;
            bank[REG_FP] <= 0;
        end else if (write_en_i) begin
            bank[regsel_i] <= regval_i;
        end
    end

    assign regval_o = bank[regsel_i];
endmodule
