//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

//
// CPU control unit
//
// @clk_i:   Clock input
// @reset_i: Reset input
// @inst_i:  Instruction input
// @pc_o:    PC output
//
module cpu_ctl #(
    parameter WORD_BITS = 64,
    parameter OPCODE_NOP = 8'h00,
    parameter OPCODE_HLT = 8'h01,
    parameter OPCODE_IMOV = 8'h02
) (
    input wire clk_i,
    input wire reset_i,
    /* verilator lint_off UNUSEDSIGNAL */
    input wire [31:0] inst_i,
    input wire [WORD_BITS-1:0] regval_i,

    output logic [31:0] pc_o,
    output logic [4:0] regsel_o,
    output logic [WORD_BITS-1:0] regval_o,
    output logic reg_write_en_o
);
    logic [31:0] pc;
    logic [31:0] inst;
    logic [4:0] state;
    logic [63:0] imm;
    logic need_decode;
    logic pc_inhibit;

    assign pc_o = pc;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            pc <= 0;
            state <= 0;
            need_decode <= 0;
            pc_inhibit <= 0;
            regsel_o <= 0;
            regval_o <= 0;
            reg_write_en_o <= 0;
            imm <= 0;
        end else if (!need_decode && !pc_inhibit) begin
            case (state)
                0:  state <= state + 1;
                1:  state <= state + 1;
                2:  state <= state + 1;
                3:  state <= state + 1;
                4:  state <= state + 1;
                5:  state <= state + 1;
                6:  state <= state + 1;
                7:  state <= state + 1;
                8:  begin
                    inst <= inst_i;
                    need_decode <= 1;
                    state <= 0;
                    pc <= pc + 4;
                end
            endcase
        end else if (need_decode) begin
            need_decode <= 0;
            reg_write_en_o <= 0;
            case (inst[7:0])
                OPCODE_NOP: ;
                OPCODE_HLT: pc_inhibit <= 1;
                OPCODE_IMOV: begin
                    regsel_o[4:0] <= inst[12:8];
                    regval_o[15:0] <= inst[31:16];
                    reg_write_en_o <= 1;
                end
                default: ;
            endcase
        end
    end
endmodule
