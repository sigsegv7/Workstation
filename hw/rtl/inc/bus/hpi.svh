//
// Copyright (c) 2026, Mirocom Laboratories
// Provided under the BSD-3 clause
//

`ifndef BUS_HPI_SVH
`define BUS_HPI_SVH 1

//
// Represents valid HPI packet kinds
//
// @HPI_KIND_INVALID:  Invalid and ignored
// @HPI_KIND_ROM_REQ:  ROM block request
// @HPI_KIND_ROM_DATA: ROM block response
//
typedef enum logic [7:0] {
    HPI_KIND_INVALID,
    HPI_KIND_ROM_REQ,
    HPI_KIND_ROM_DATA
} hpi_kind_t;

//
// Represents a node connected to the HPI fabric
//
// @HPI_NODE_UNSPEC: Unspecified node
// @HPI_NODE_PE:     Processing element
// @HPI_NODE_ROM:    ROM block
//
typedef enum logic [7:0] {
    HPI_NODE_UNSPEC,
    HPI_NODE_PE,
    HPI_NODE_ROM
} hpi_node_t;

//
// Represents a ROM block request packet
//
// @addr:       Address to request read from
// @reserved:   Reserved, must be zero
//
typedef struct packed {
    logic [31:0] addr;
    logic [95:0] reserved;
} hpi_rom_req_t;

//
// Represents a ROM block response packet
//
// @data: Data response
// @reserved:   Reserved, must be zero
//
typedef struct packed {
    logic [31:0] data;
    logic [95:0] reserved;
} hpi_rom_data_t;

//
// Represents a packet that may be sent over the Mirocom
// High Performance Interconnect (HPI) fabric.
//
// @kind:       Packet kind
// @src:        Source node
// @dest:       Destination node
// @src_leaf:   Source instance number
// @dest_leaf:  Destination instance number
// @payload:    Packet payload
//
typedef struct packed {
    hpi_kind_t kind;
    hpi_node_t src;
    hpi_node_t dest;
    logic [7:0] src_leaf;
    logic [7:0] dest_leaf;
    logic [127:0] payload;
} hpi_packet_t;

`endif  /* !BUS_HPI_SVH */
