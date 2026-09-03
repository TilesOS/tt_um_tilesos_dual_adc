# Final design and verification notes

The electrical and physical decisions formerly tracked here as open are now
closed in the production custom-GDS revision. The generated Tiny Tapeout
datasheet in [`../docs/info.md`](../docs/info.md) is the user-facing authority;
this file records the compact engineering boundary.

## Frozen interface

- `ua[0]`: shared 0.750--1.200 V analog input
- `ua[1]`: buffered delta-sigma loop-state monitor
- `uo_out[0]`: asynchronous VCO pulse train
- `uo_out[1]`: raw delta-sigma one-bit stream
- `clk`: nominal 1 MHz delta-sigma clock
- `rst_n`: active-low delta-sigma reset
- `VDPWR` / `VGND`: 1.8 V supply and ground

The project does not use `VAPWR`, `ena`, `ui_in`, or `uio_in`. Every unused
digital output is tied to ground and every unused analog pad is isolated.

## Final physical closure

The promoted hierarchy passes full Magic DRC, unique LVS, exact antenna audit,
semantic GDS round trip, Tiny Tapeout precheck, and independent-build
reproducibility. Drawn bounds are 334.86 x 225.76 um within the official 2x2
frame, and no user geometry uses Metal5. The formal interface contains 53
ports and 31 unique electrical nets, including 22 intentional ground aliases.

The final top-level extracted netlist has 180 devices and 63 nets per LVS
side. Worst user-route resistance is 153.599790 ohm on VDPWR and 475.701875
ohm on VGND. The two converter domains share no post-boundary VDPWR resistor
component, and their directly extracted coupling is 20.658780 fF.

## Electrical closure

The final coexistence replay holds VCO frequency to 0.001026% change when the
delta-sigma path is activated, produces delta-sigma density 0.500000 at the
center input, and keeps the continuous loop state at 0.819201--1.006700 V.
The complete numerical characterization is kept in `docs/info.md` so it has a
single public source.

## Residual limitations

All performance numbers are simulations or extracted-layout checks rather
than measured-silicon guarantees. The VCO needs per-die calibration; physical
jitter and phase noise await silicon. Mismatch seeds were not reproducible
enough to claim a statistical yield percentile. Delta-sigma SNDR and ENOB are
finite-record nominal extracted results and do not include board, package,
source, or clock imperfections.
