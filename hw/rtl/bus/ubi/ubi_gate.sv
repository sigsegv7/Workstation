//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/ubi.svh"

//
// Unified bus interface (UBI) gate
//
// @clk_i:      Clock input
// @reset_i:    Reset input
// @ad_i:       Address input
//
module ubi_gate #(
    parameter SOURCE_NODE = HPI_NODE_PE,
    parameter SOURCE_LEAF = 0
) (
    input wire clk_i,
    input wire reset_i,
    input wire [31:0] ad_i
);
    /* verilator lint_off UNUSEDSIGNAL */
    hpi_packet_t hpi_pkt;
    ubi_mementry_t mementry;
    logic [31:0] ad_tmp;
    logic [31:0] ad;
    logic map_req;
    logic [2:0] stage;

    // Map resolver
    ubi_map resolver (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .req_i(map_req),
        .ad_i(ad),
        .entry_o(mementry)
    );

    ubi_marshall #(.SOURCE_NODE(SOURCE_NODE), .SOURCE_LEAF(SOURCE_LEAF))
    marshaller (
        .ad_i(ad),
        .mementry_i(mementry),
        .hpi_pkt_o(hpi_pkt)
    );

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            ad <= 32'hFFFFFFFF;
            stage <= 0;
            map_req <= 0;
        end else if (ad_i != ad && stage == 0) begin
            ad_tmp <= ad_i;
            stage <= stage + 1;
        end else if (stage == 1) begin
            ad <= ad_i;
            stage <= stage + 1;
        end else if (stage == 2) begin
            map_req <= 1;
            stage <= stage + 1;
        end else if (stage == 3) begin
            map_req <= 0;
            stage <= 0;
        end
    end
endmodule
