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
