<!---
This file generates the project datasheet. Images in this folder can be
referenced in markdown; each < 512 kB, combined < 1 MB.
-->

## How it works

This project places **two independent first-order noise-shaping ADCs on one die,
sharing a single analog input**, so they can be compared head-to-head under
identical stimulus, process, and temperature.

**Shared input.** `ua[0]` drives both converters simultaneously.

**Path A — VCO-based ADC (`uo_out[0]`).** A current-starved ring oscillator turns
the input voltage into a frequency (Vin → f). Counting oscillator edges over a
fixed window off-chip recovers the signal. Because oscillator phase is the
*integral* of frequency and counting is a *difference* of phase, the ±1-count
quantization error is first-order high-pass shaped (+20 dB/decade) — it is a
genuine ΔΣ-class converter, but built almost entirely from digital-style
structures, so it is compact and robust. Its accuracy is limited by (a) the
nonlinearity of the Vin→f curve, which is removed by a one-time off-chip
calibration of the static curve, and (b) oscillator phase noise.

**Path B — First-order delta-sigma modulator (`uo_out[1]`).** A switched-capacitor
integrator (built around a compact OTA), a 1-bit comparator, and a 1-bit feedback
DAC form a classic ΔΣ loop. The loop shapes quantization noise out of band; an
off-chip digital low-pass + decimation recovers a high-resolution sample stream.
The integrator output is brought out on `ua[1]` as a debug node.

**Timing.** `clk` is the 1 MHz master. The ΔΣ modulator samples at the oversampling
clock; the VCO count window is derived by division. Target oversampling ratio
≈ 128 (≈ 9-bit ENOB in simulation for the ΔΣ; ≥ 8-bit for the VCO path after
static calibration).

**Design-for-fallback.** The VCO path is the low-risk "guaranteed win": if the ΔΣ
loop underperforms, the chip still yields measurable, publishable results. This is
deliberate hedging, not an accident.

## How to test

1. **Power/clock.** Apply 1.8 V (VDPWR), ground (VGND), and a clock on `clk`
   (start ~1 MHz). Release `rst_n`.
2. **Stimulus.** Drive a slow, band-limited sine into `ua[0]` (respect the pad
   path limits: R < 500 Ω, C < 5 pF, |I| < 4 mA).
3. **VCO path.** Capture the pulse train on `uo_out[0]` with a counter (FPGA /
   Tiny Tapeout Commander). Count edges per fixed window → raw code. Apply the
   pre-characterized Vin→f inverse (calibration) to linearize.
4. **ΔΣ path.** Capture the bitstream on `uo_out[1]`. Run an off-chip sinc/FIR
   decimation filter, then FFT for SNR/ENOB and the noise-shaping slope.
5. **Debug.** Monitor the ΔΣ integrator on `ua[1]` (e.g., Analog Discovery 3) to
   confirm the loop is integrating and not railed.
6. **The experiment.** Feed both paths the same tone and compare SNR, ENOB,
   linearity, and noise-shaping slope — a controlled architectural comparison.

## External hardware

- Analog signal source for `ua[0]` (e.g., Analog Discovery 3).
- Edge counter / bitstream capture: FPGA (Nexys A7) or Tiny Tapeout Commander.
- Off-chip DSP (Python or FPGA) for decimation, calibration, and FFT/ENOB.
- Tiny Tapeout demo + breakout board.
