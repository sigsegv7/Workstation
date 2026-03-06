//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/hpi.svh"

//
// On-chip mainbus
//
// @clk_i:    Clock input
// @reset_i:  Reset input
//
module mainbus (
    input wire clk_i,
    input wire reset_i
);
    // Request ring injection port feeders
    hpi_packet_t r_rs0_lip0_feed;
    hpi_packet_t r_rs1_lip0_feed;

    // Data ring injection port feeders
    hpi_packet_t d_rs0_lip0_feed;
    hpi_packet_t d_rs1_lip0_feed;

    // Request ring tap feeders
    /* verilator lint_off UNUSEDSIGNAL */
    hpi_packet_t r_rs0_tap;
    hpi_packet_t r_rs1_tap;

    // Data ring tap feeders
    hpi_packet_t d_rs0_tap;
    hpi_packet_t d_rs1_tap;

    // Request ring
    hpi_ringbus req_ring (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .rs0_lip0_i(r_rs0_lip0_feed),
        .rs1_lip0_i(r_rs1_lip0_feed),
        .rs0_tap_o(r_rs0_tap),
        .rs1_tap_o(r_rs1_tap)
    );

    // Data ring
    hpi_ringbus data_ring (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .rs0_lip0_i(d_rs0_lip0_feed),
        .rs1_lip0_i(d_rs1_lip0_feed),
        .rs0_tap_o(d_rs0_tap),
        .rs1_tap_o(d_rs1_tap)
    );

    // Processing domain 0 : RINGSTOP 0
    cpu_pd pd0 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .bus_lip0_o(r_rs0_lip0_feed)
    );

    // I/O block : RINGSTOP 1
    uncore_ioblk ioblk (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .hpi_r0_tap_i(r_rs1_tap),
        .hpi_d0_lip_o(d_rs1_lip0_feed)
    );

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            d_rs0_lip0_feed <= 0;
            r_rs1_lip0_feed <= 0;
        end
    end
endmodule
