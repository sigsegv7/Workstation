//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/hpi.svh"

//
// High performance interconnect (HPI) ring
//
// @clk_i:          Clock input
// @reset_i:        Reset input
// @rs<n>_lip0_i:   Ringstop link injection port 0
// @rs<n>_tap_o:    Ringstop link tap
//
module hpi_ringbus (
    input wire clk_i,
    input wire reset_i,
    input hpi_packet_t rs0_lip0_i,
    input hpi_packet_t rs1_lip0_i,

    output hpi_packet_t rs0_tap_o,
    output hpi_packet_t rs1_tap_o
);
    // Ringstop feeders
    hpi_packet_t rs0_feed;
    hpi_packet_t rs1_feed;

    // Ringstop 0
    hpi_ringstop rs0 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .link_i(rs0_feed),
        .lip0_i(rs0_lip0_i),
        .link_o(rs1_feed)
    );

    // Ringstop 1
    hpi_ringstop rs1 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .link_i(rs1_feed),
        .lip0_i(rs1_lip0_i),
        .link_o(rs0_feed)
    );

    assign rs0_tap_o = rs0_feed;
    assign rs1_tap_o = rs1_feed;
endmodule
