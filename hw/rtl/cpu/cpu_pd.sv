//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

//
// CPU processing domain containing one or more processing elements
// as well as other components.
//
// @clk_i:   Clock input
// @reset_i: Reset input
//
module cpu_pd (
    input wire clk_i,
    input wire reset_i,

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
        .ad_o(ad)
    );

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            ad <= 0;
        end
    end
endmodule
