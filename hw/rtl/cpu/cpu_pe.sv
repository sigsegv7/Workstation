//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

//
// CPU processing element
//
// @clk_i:   Clock input
// @reset_i: Reset input
//
// addr_o:   Address output
//
module cpu_pe (
    input wire clk_i,
    input wire reset_i,

    output logic [31:0] ad_o
);
    logic [31:0] pc;

    // Control unit
    cpu_ctl ctl_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .pc_o(pc)
    );

    // Fetch unit
    cpu_fetch fetch_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .pc_i(pc),
        .addr_o(ad_o)
    );
endmodule
