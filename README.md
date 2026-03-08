# Mirocom workstation

## What is this?

Mirocom workstation is a 64-bit workstation with a 250 MHz Mirocom System-on-Chip (SoC) aimed at those who can live with minimalism and want
a breath of fresh air from the existing modern or proprietary ecosystems.

## Goals

- Implementation of uncore debug unit
- Implementation of stage 1 platform firmware ROM
- Implementation of processing elements
- Implementation of ALU
- Implementation of interrupts

## Features

- Efficient system bus via Mirocom High Performance Interconnect (HPI)

- Processor initiated addressing via Mirocom Unified Bus Interface (UBI)

## Project directory structure

```
hw/         : Workstation hardware specifics
doc/        : Workstation documentation
toolchain/  : Workstation toolchain
firmware/   : Workstation firmware
```
