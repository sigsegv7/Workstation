//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

//
// CPU fetch unit
//
// @clk_i:      Clock input
// @reset_i:    Reset input
// @pc_i:       Program counter input
// @addr_o:     Address out
//
// TODO: Actually fetch the data from memory
//
module cpu_fetch (
    input wire clk_i,
    input wire reset_i,
    input wire [31:0] pc_i,

    output logic [31:0] addr_o
);
    logic [31:0] pc;
    logic [2:0] state;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            pc <= 0;
            state <= 0;
            addr_o <= 0;
        end else if (pc != pc_i || state > 0) begin
            case (state)
                0: begin
                    pc <= pc_i;
                    addr_o <= pc_i;
                    state <= state + 1;
                end

                // Wait two cycles
                1: state <= state+ 1;
                2: state <= 0;
            endcase
        end
    end
endmodule
