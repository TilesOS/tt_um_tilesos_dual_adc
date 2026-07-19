# Design notes and open decisions

These items must be resolved before the schematic and layout can be considered
stable.

## Electrical interface

- Define the legal `ua[0]` voltage range and common mode.
- Define the internal reference, feedback-DAC levels, and bias startup.
- Budget total input capacitance and resistance against the Tiny Tapeout analog
  path limits.
- Prevent switched-capacitor kickback from modulating the VCO path.
- Buffer `ua[1]`; do not expose the integrator storage node directly.
- Establish minimum and maximum VCO frequency across PVT and verify that the
  digital output path and capture hardware can handle it.

## Clocking and reset

- Generate non-overlapping switched-capacitor phases from `clk`.
- Define reset assertion and release behavior for the integrator, comparator,
  feedback DAC, oscillator, and output buffers.
- Keep the VCO measurement window off-chip unless the interface is explicitly
  extended to implement it on-chip.

## Verification before final submission

- Schematic-level functional simulation.
- Process, voltage, and temperature corners.
- Device-mismatch Monte Carlo.
- Noise, linearity, stability, and startup verification.
- DRC and LVS.
- Parasitic extraction and post-layout simulation.
- Tiny Tapeout precheck, including exact pin geometry, analog-pin connectivity,
  power ports, boundary, forbidden-layer, and cell-name checks.
- Physical tie-down of every unused `uo_out`, `uio_out`, and `uio_oe` bit.
