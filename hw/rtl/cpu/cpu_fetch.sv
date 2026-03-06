//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/hpi.svh"

//
// CPU fetch unit
//
// @clk_i:      Clock input
// @reset_i:    Reset input
// @pc_i:       Program counter input
// @bus_d_tap_i:    Bus tap input
// @addr_o:     Address out
// @inst_o:     Instruction out
//
module cpu_fetch (
    input wire clk_i,
    input wire reset_i,
    input wire [31:0] pc_i,
    /* verilator lint_off UNUSEDSIGNAL */
    input hpi_packet_t bus_d_tap_i,

    output logic [31:0] addr_o,
    output logic [31:0] inst_o
);
    logic [31:0] pc;
    logic [3:0] state;
    hpi_rom_data_t rom_data;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            pc <= 32'hFFFFFFFF;
            state <= 0;
            addr_o <= 32'hFFFFFFFF;
            inst_o <= 0;
        end else if (pc != pc_i || state > 0) begin
            case (state)
                0: begin
                    pc <= pc_i;
                    addr_o <= pc_i;
                    state <= state + 1;
                end

                1: begin
                    if (bus_d_tap_i.kind == HPI_KIND_ROM_DATA) begin
                        rom_data <= bus_d_tap_i.payload;
                        state <= state + 1;
                    end
                end
                2: begin
                    inst_o <= rom_data.data;
                    state <= 0;
                end
            endcase
        end
    end
endmodule
