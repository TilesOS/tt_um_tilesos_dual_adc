/*
 * Copyright (c) 2026 Tyler McClure (TilesOS)
 * SPDX-License-Identifier: Apache-2.0
 *
 * Black-box interface for the custom analog GDS/LEF implementation.
 *
 *   ua[0]     Shared analog input
 *   ua[1]     Buffered delta-sigma integrator monitor
 *   uo_out[0] VCO-ADC pulse train, counted off-chip
 *   uo_out[1] Delta-sigma bitstream
 *   clk       1 MHz delta-sigma sampling clock
 *   rst_n     Active-low reset
 *
 * Unused uo_out, uio_out, and uio_oe pins must be tied to VGND in layout.
 */

`default_nettype none

module tt_um_tilesos_dual_adc (
    input  wire       VGND,
    input  wire       VDPWR,    // 1.8 V power supply
//  input  wire       VAPWR,    // Optional 3.3 V supply; not used
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: input path
    output wire [7:0] uio_out,  // IOs: output path
    output wire [7:0] uio_oe,   // IOs: enable path, active high
    inout  wire [7:0] ua,       // Analog pins; only ua[5:0] can be used
    input  wire       ena,      // Always 1 when powered
    input  wire       clk,      // Clock
    input  wire       rst_n     // Active-low reset
);

endmodule
