//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`ifndef BUS_UBI_SVH
`define BUS_UBI_SVH 1

//
// Valid memory entry types
//
// @UBI_MEMTYPE_INVALID: Invalid type
// @UBI_MEMTYPE_USABLE:  Usable memory
// @UBI_MEMTYPE_ROM:     ROM block
//
typedef enum logic [7:0] {
    UBI_MEMTYPE_INVALID,
    UBI_MEMTYPE_USABLE,
    UBI_MEMTYPE_ROM
} ubi_memtype_t;

//
// Represents a platform memory map entry
//
// @ubi_memtype_t: Region type
// @region_start:  Start address of region
// @region_end:    End address of region
//
typedef struct packed {
    ubi_memtype_t kind;
    logic [31:0] region_start;
    logic [31:0] region_end;
} ubi_mementry_t;

`endif  /* !BUS_UBI_SVH */
