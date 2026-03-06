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
module cpu_pe (
    input wire clk_i,
    input wire reset_i,
    input hpi_packet_t bus_d_tap_i,

    output logic [31:0] ad_o
);
    logic [31:0] pc;
    logic [31:0] inst;

    // Control unit
    cpu_ctl ctl_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .inst_i(inst),
        .pc_o(pc)
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
