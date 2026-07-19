/*
 * Copyright (c) 2026 Tyler McClure (TilesOS)
 * SPDX-License-Identifier: Apache-2.0
 *
 * Blackbox stub for the analog top level. Tiny Tapeout integrates the design
 * from the GDS/LEF; this Verilog only declares the port interface so the
 * shuttle harness can wire it up. The actual circuits are drawn in Magic.
 *
 * Pin map (see info.yaml / docs/info.md):
 *   ua[0]    Vin  — shared analog input to both ADCs
 *   ua[1]    Delta-sigma integrator output (debug node)
 *   uo_out[0] VCO-ADC pulse train      (count off-chip)
 *   uo_out[1] Delta-sigma bitstream
 *   clk       1 MHz master (ΔΣ oversampling clock; VCO count window derived)
 *   rst_n     active-low reset
 *   Unused uo_out/uio_out/uio_oe MUST be tied to GND in layout (no floating digital outputs).
 */

`default_nettype none

module tt_um_tilesos_dual_adc (
    input  wire       VGND,
    input  wire       VDPWR,    // 1.8v power supply
//    input  wire       VAPWR,    // 3.3v supply — NOT used (1.8V design); keep commented
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    inout  wire [7:0] ua,       // Analog pins, only ua[5:0] can be used
    input  wire       ena,      // always 1 when powered (ignore)
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

endmodule
