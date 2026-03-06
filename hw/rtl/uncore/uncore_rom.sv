//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/hpi.svh"

//
// Uncore ROM module
//
// @clk_i:   Clock input
// @reset_i: Reset input
// @hpi_r_tap_i: High performance interconnect tap
// @hpi_data_lip0: Data injection port
//
module uncore_rom #(
    parameter BUS_WIDTH = 32
) (
    input wire clk_i,
    input wire reset_i,
    input hpi_packet_t hpi_r_tap_i,

    output hpi_packet_t hpi_d_lip_o
);
    // 8K stage 1 ROM
    logic [BUS_WIDTH-1:0] rom [0:2047];
    logic [4:0] stage;
    hpi_rom_data_t rom_data_packet;
    hpi_packet_t data_packet;

    /* verilator lint_off UNUSEDSIGNAL */
    hpi_rom_req_t rom_req_packet;
    hpi_packet_t req_packet;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            hpi_d_lip_o <= 0;
            $readmemh("fw.mem", rom);
        end else if (hpi_r_tap_i.dest == HPI_NODE_ROM || stage > 0) begin
            case (stage)
                0: begin
                    if (hpi_r_tap_i.kind == HPI_KIND_ROM_REQ) begin
                        req_packet <= hpi_r_tap_i;
                        rom_req_packet <= hpi_rom_req_t'(hpi_r_tap_i.payload);
                        stage <= stage + 1;
                    end
                end
                1: begin
                    rom_data_packet.reserved <= 0;
                    rom_data_packet.data <= rom[rom_req_packet.addr>>2];
                    stage <= stage + 1;
                end
                2: begin
                    data_packet.kind <= HPI_KIND_ROM_DATA;
                    data_packet.dest <= req_packet.src;
                    data_packet.src <= HPI_NODE_ROM;
                    data_packet.dest_leaf <= req_packet.src_leaf;
                    data_packet.src_leaf <= 0;
                    data_packet.payload <= rom_data_packet;
                    stage <= stage + 1;
                end
                3: begin
                    // TODO : POLL READY
                    hpi_d_lip_o <= data_packet;
                    stage <= stage + 1;
                end

                // Hold the lines high
                4: stage <= stage + 1;
                5: stage <= stage + 1;
                6: stage <= stage + 1;
                7: stage <= stage + 1;
                8: stage <= stage + 1;
                9: stage <= stage + 1;
                10: begin
                    stage <= 0;
                    hpi_d_lip_o <= 0;
                end
            endcase
        end
    end
endmodule
