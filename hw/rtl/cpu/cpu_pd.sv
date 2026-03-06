//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/hpi.svh"

//
// CPU processing domain containing one or more processing elements
// as well as other components.
//
// @clk_i:          Clock input
// @reset_i:        Reset input
// @bus_d_tap_i:    Bus tap input
// @bus_lip0_o:     Bus injection port output
//
module cpu_pd (
    input wire clk_i,
    input wire reset_i,
    input hpi_packet_t bus_d_tap_i,

    output hpi_packet_t bus_lip0_o
);
    // Feeders
    logic [31:0] ad;

    // UBI gate 0
    ubi_gate #(.SOURCE_NODE(HPI_NODE_PE), .SOURCE_LEAF(0)) bus_gate0 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .ad_i(ad),
        .bus_lip0_o(bus_lip0_o)
    );

    // Processing element 0
    cpu_pe core0 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .bus_d_tap_i(bus_d_tap_i),
        .ad_o(ad)
    );
endmodule
