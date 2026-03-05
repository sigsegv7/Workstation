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
    // Injection port feeders
    hpi_packet_t rs0_lip0_feed;
    hpi_packet_t rs1_lip0_feed;

    // Request ring
    hpi_ringbus req_ring (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .rs0_lip0_i(rs0_lip0_feed),
        .rs1_lip0_i(rs1_lip0_feed)
    );

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            rs0_lip0_feed <= 0;
            rs1_lip0_feed <= 0;
        end
    end
endmodule
