# The Mirocom Workstation Architecture Reference Manual

The document describes the architecture powering Mirocom Workstation and targets developers of system software,
platform firmware and more.

## Machine reset behavior

### Phase locked loop (PLL)

The Mirocom Workstation System-on-Chip (SoC) package contains a Phase Locked Loop (PLL)
used to generate the clock signal of the root clock domain. There is a period in which
it takes for the output signal to be stabilized (locked). The SoC needs to be held in a
reset state until the PLL is locked.

### RESET# line

The System-on-Chip (SoC) package exposes a RESET# line that once pulled low results
in a machine reset state where all state machines, registers and output signals are
to be set to their designated reset state. This reset line is normalized and coverted
to an internal active-high signal referred to as the "internal reset register".

### CPU reset state

Upon an active state of the internal reset register, all special registers as well as control registers
are to be initialized to a value of zero. All general purpose registers and ABI registers are to be
initialized to a fixed bit-pattern of 0xAAAAAAAAAAAAAAAA.
