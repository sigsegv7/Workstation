//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

//
// Mirocom workstation System-on-Chip (SoC) package
//
// @clk_i:     Clock input
// @reset_i:   Reset input
//
module soc (
    input wire clk_i,
    input wire reset_i
);
    /* verilator lint_off UNUSEDSIGNAL */
    logic clk;
    logic reset;
`ifndef WORKSTATION_SIM
    logic pll_locked;

    // PLL for 250 MHz root clock domain
    pll root_pll (
        .refclk(clk_i),
        .rst(~reset_i),
        .outclk_0(clk),
        .locked(pll_locked)
    );

    // Reset bridge
    always_ff @(posedge clk) begin
        reset <= ~reset_i | ~pll_locked;
    end
`else
    assign clk = clk_i;
    assign reset = ~reset_i;
`endif  /* !WORKSTATION_SIM */
endmodule
