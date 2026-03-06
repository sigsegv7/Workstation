//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`include "bus/ubi.svh"

//
// Unified bus interface (UBI) map manager
//
// @clk_i:   Clock input
// @reset_i: Reset input
// @req_i:   Request input
// @ad_i:    Address input
// @entry_o: Memory map entry output
//
module ubi_map #(
    parameter MAP_ENTRIES = 2
) (
    input wire clk_i,
    input wire reset_i,
    input wire req_i,
    input wire [31:0] ad_i,

    output ubi_mementry_t entry_o
);
    integer i;
    ubi_mementry_t map [0:MAP_ENTRIES-1] = '{
        '{
            UBI_MEMTYPE_INVALID,        // Type
            32'h00000000,               // Start
            32'h00000000                // End
         },

        '{
            UBI_MEMTYPE_ROM,            // Type
            32'h00000000,               // Start
            32'h00002000                // End
         }
    };

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            entry_o <= 0;
        end else if (req_i) begin
            for (i = 0; i < MAP_ENTRIES; i = i + 1) begin
                if (ad_i >= map[i].region_start && ad_i <= map[i].region_end) begin
                    entry_o <= map[i];
                end
            end
        end
    end
endmodule
