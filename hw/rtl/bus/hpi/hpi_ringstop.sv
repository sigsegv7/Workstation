//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/hpi.svh"

//
// High performance interconnect (HPI) ringstop
//
// @clk_i:   Clock input
// @reset_i: Reset input
// @link_i:  Inbound transport link
// @lip0_i:  Transport link injection port 0
// @link_o:  Outbound transport link
//
module hpi_ringstop #(
    parameter MUX_PERIOD = 2,
    parameter MUX_INPUTS = 2,
    parameter MUX_CAP = (MUX_PERIOD * MUX_INPUTS)
) (
    input wire clk_i,
    input wire reset_i,
    input hpi_packet_t link_i,
    input hpi_packet_t lip0_i,

    output hpi_packet_t link_o
);
    logic [2:0] mux_sel;

    // Splice the injection port
    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            link_o <= 0;
            mux_sel <= 0;
        end else begin
            case (mux_sel)
                // TDM slice 0
                0: link_o <= link_i;
                1: link_o <= link_i;

                // TDM slice 1
                2: link_o <= lip0_i;
                3: link_o <= lip0_i;

                // Fallback
                default: link_o <= link_i;
            endcase

            // Wrap if needed
            if (mux_sel < MUX_CAP + 1) begin
                mux_sel <= mux_sel + 1;
            end else begin
                mux_sel <= 0;
            end
        end
    end
endmodule
