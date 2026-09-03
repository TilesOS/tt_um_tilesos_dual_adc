[![gds](https://github.com/TilesOS/tt_um_tilesos_dual_adc/actions/workflows/gds.yaml/badge.svg)](https://github.com/TilesOS/tt_um_tilesos_dual_adc/actions/workflows/gds.yaml)
[![docs](https://github.com/TilesOS/tt_um_tilesos_dual_adc/actions/workflows/docs.yaml/badge.svg)](https://github.com/TilesOS/tt_um_tilesos_dual_adc/actions/workflows/docs.yaml)

# Dual-Path Noise-Shaping ADC

This Tiny Tapeout SKY130 analog project places two independent ADC approaches
behind one shared input:

- a five-stage current-starved ring-oscillator ADC on `uo_out[0]`, decoded by
  off-chip frequency counting and per-die calibration; and
- a first-order switched-capacitor delta-sigma modulator on `uo_out[1]`,
  decoded by off-chip filtering and decimation.

Both paths observe `ua[0]`. A buffered delta-sigma loop-state monitor is
available on `ua[1]`. The characterized operating point is a 1.8 V supply,
0.750--1.200 V input range, and 1 MHz delta-sigma clock.

## Production status

The custom GDS revision at commit `6b4c73e7300f83f4c6927598db11381399d74f52`
completed final DRC, LVS, extraction, antenna, topology, coexistence, and
reproducibility closure and passed the Tiny Tapeout automated submission
checks. Subsequent documentation-only changes do not alter the frozen layout
artifacts.

## Documentation

- [`docs/info.md`](docs/info.md) is the main public project datasheet and the
  source used by Tiny Tapeout's documentation workflow.
- [`extra-details/design-notes.md`](extra-details/design-notes.md) records the
  compact engineering boundary and residual limitations.
- [`extra-details/def/README.md`](extra-details/def/README.md) identifies the
  pinned official analog DEF template used for layout closure.

Repository-level characterization, physical-signoff evidence, and historical
development notes live in the parent Tapeout workspace.
