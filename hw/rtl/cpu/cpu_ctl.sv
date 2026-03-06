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
module cpu_ctl (
    input wire clk_i,
    input wire reset_i,
    /* verilator lint_off UNUSEDSIGNAL */
    input wire [31:0] inst_i,

    output logic [31:0] pc_o
);
    logic [31:0] pc;
    logic [2:0] state;

    assign pc_o = pc;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            pc <= 0;
            state <= 0;
        end else begin
            case (state)
                0:  state <= state + 1;
                1:  state <= state + 1;
                2:  state <= state + 1;
                3:  state <= state + 1;
                4:  state <= state + 1;
                5:  begin
                    state <= 0;
                    pc <= pc + 4;
                end
            endcase

        end
    end
endmodule
