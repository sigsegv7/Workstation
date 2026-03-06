//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/ubi.svh"
`include "bus/hpi.svh"

//
// Unified bus interface (UBI) marshaller
//
// @ad_i:       Address input
// @mementry_i: Memory map entry to convert
// @hpi_pkt_o:  HPI packet result is written here
//
module ubi_marshall #(
    parameter SOURCE_NODE = HPI_NODE_PE,
    parameter SOURCE_LEAF = 0
) (
    /* verilator lint_off UNUSEDSIGNAL */
    input wire [31:0] ad_i,
    input ubi_mementry_t mementry_i,

    output hpi_packet_t hpi_pkt_o
);
    hpi_packet_t packet;
    hpi_rom_req_t rom_packet;

    always_comb begin
        case (mementry_i.kind)
            UBI_MEMTYPE_ROM: begin
                rom_packet.addr = ad_i;
                rom_packet.reserved = 0;
                packet.kind = HPI_KIND_ROM_REQ;
                packet.src = hpi_node_t'(SOURCE_NODE);
                packet.dest = HPI_NODE_ROM;
                packet.src_leaf = SOURCE_LEAF;
                packet.dest_leaf = 0;
                packet.payload = rom_packet;
                hpi_pkt_o = packet;
            end
            default: hpi_pkt_o = 0;
        endcase
    end
endmodule
