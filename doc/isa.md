# The Mirocom A1 Instruction Set Architecture

The document describes the A1 instruction set architecture for developers of system software, platform firmware and
chip designers.

## Instructions

A1 relies on 32-bit fixed-width instructions stored in memory that the processor fetches, decodes and executes.

### Instruction format

### A-type instructions

```
+------------------------+
| Opcode     Reserved    |
|  7:0        31:8       |
+------------------------+
```

### B-type instructions

```
+------------------------------+
| Opcode     Register   Imm    |
|  7:0        15:8      31:16  |
+------------------------------+
```

## Instruction listing

```
NAME       OPCODE    Description          TYPE
-------------------------------------------------------
NOP        0x00      No-operation         [A]
HLT        0x01      Halt processor       [A]
MOV        0x02      Move IMM to reg      [B]
RSVD       0x03      Reserved             [N/A]
ADD        0x04      Add IMM to reg       [B]
SUB        0x05      Sub IMM from reg     [B]
AND        0x06      AND IMM to reg       [B]
OR         0x07      OR IMM to reg        [B]
-------------------------------------------------------
```

## Processor registers

```
NAME  ID     SIZE   Description
---------------------------------------
R0 : 0x00 : 64-bits  General
R1 : 0x01 : 64-bits  General
R2 : 0x02 : 64-bits  General
R3 : 0x03 : 64-bits  General
R4 : 0x04 : 64-bits  General
R5 : 0x05 : 64-bits  General
R6 : 0x06 : 64-bits  General
R7 : 0x07 : 64-bits  General
A0 : 0x08 : 64-bits  ABI-defined
A1 : 0x09 : 64-bits  ABI-defined
A2 : 0x0A : 64-bits  ABI-defined
A3 : 0x0B : 64-bits  ABI-defined
A4 : 0x0C : 64-bits  ABI-defined
A5 : 0x0D : 64-bits  ABI-defined
A6 : 0x0E : 64-bits  ABI-defined
A7 : 0x0F : 64-bits  ABI-defined
TT : 0x10 : 64-bits  Translation table
SP : 0x11 : 64-bits  Stack pointer
FP : 0x12 : 64-bits  Frame pointer
---------------------------------------
```
