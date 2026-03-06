//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/hpi.svh"

//
// Uncore I/O block
//
// @clk_i:         Clock input
// @reset_i:       Reseet input
// @hpi_r0_tap_i:  HPI request ring tap
// @hpi_d0_lip_o:  HPI link injection port
//
module uncore_ioblk (
    input wire clk_i,
    input wire reset_i,
    input hpi_packet_t hpi_r0_tap_i,

    output hpi_packet_t hpi_d0_lip_o
);
    // Platform firmware ROM
    uncore_rom pfw_rom0 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .hpi_r_tap_i(hpi_r0_tap_i),
        .hpi_d_lip_o(hpi_d0_lip_o)
    );
endmodule
