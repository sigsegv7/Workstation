//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/hpi.svh"

//
// Unified bus interface (UBI) router
//
// @clk_i:   Clock input
// @reset_i: Reset input
// @req_i:   Request input
// @hpi_i:   HPI packet input
// @hpi_o:   HPI packet output
//
module ubi_router (
    input wire clk_i,
    input wire reset_i,
    input wire req_i,
    input hpi_packet_t hpi_i,

    output hpi_packet_t hpi_o
);
    logic [2:0] stage;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            hpi_o <= 0;
            stage <= 0;
        end else if (req_i || stage > 0) begin
            case (stage)
                // Begin bus TX
                0: begin
                    hpi_o <= hpi_i;
                    stage <= stage + 1;
                end

                // Wait 6 cycles
                1: stage <= stage + 1;
                2: stage <= stage + 1;
                3: stage <= stage + 1;
                4: stage <= stage + 1;
                5: stage <= stage + 1;
                6: stage <= stage + 1;

                // Stop TX
                7: begin
                    hpi_o <= 0;
                    stage <= 0;
                end
            endcase
        end
    end
endmodule
