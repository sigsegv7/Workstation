//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/hpi.svh"

//
// CPU processing element
//
// @clk_i:   Clock input
// @reset_i: Reset input
// @bus_d_tap_i:    Bus tap input
// addr_o:   Address output
//
module cpu_pe #(
    parameter WORD_BITS = 64
) (
    input wire clk_i,
    input wire reset_i,
    input hpi_packet_t bus_d_tap_i,

    output logic [31:0] ad_o
);
    logic [31:0] pc;
    logic [31:0] inst;
    logic [4:0] regsel;
    logic [WORD_BITS-1:0] regval_feed;
    logic [WORD_BITS-1:0] regval_pool;
    logic reg_write_en;

    // Register bank
    cpu_regbank #(.WORD_BITS(WORD_BITS)) regbank0 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .regsel_i(regsel),
        .regval_i(regval_feed),
        .write_en_i(reg_write_en),
        .regval_o(regval_pool)
    );

    // Control unit
    cpu_ctl #(.WORD_BITS(WORD_BITS)) ctl_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .inst_i(inst),
        .regval_i(regval_pool),
        .pc_o(pc),
        .regsel_o(regsel),
        .regval_o(regval_feed),
        .reg_write_en_o(reg_write_en)
    );

    // Fetch unit
    cpu_fetch fetch_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .pc_i(pc),
        .bus_d_tap_i(bus_d_tap_i),
        .addr_o(ad_o),
        .inst_o(inst)
    );
endmodule
