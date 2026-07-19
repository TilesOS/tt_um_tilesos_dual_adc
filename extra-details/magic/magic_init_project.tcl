# SPDX-License-Identifier: Apache-2.0
# Copyright (c) 2024-2025 Tiny Tapeout LTD
# Copyright (c) 2026 Tyler McClure
#
# Based on TinyTapeout/tt-support-tools and configured for this project's
# 1.8 V SKY130 2x2 analog template.
#
# Run from the repository root after obtaining the DEF described in
# extra-details/def/README.md:
#
#   magic -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc
#   source extra-details/magic/magic_init_project.tcl

set TOP_LEVEL_CELL     tt_um_tilesos_dual_adc
set TEMPLATE_FILE      extra-details/def/tt_analog_2x2.def
set POWER_STRIPE_WIDTH 2um

set POWER_STRIPES {
    VDPWR 1um
    VGND  4um
}

def read $TEMPLATE_FILE
cellname rename tt_um_template $TOP_LEVEL_CELL

proc draw_power_stripe {name x} {
    global POWER_STRIPE_WIDTH
    box $x 5um $x 220.76um
    box width $POWER_STRIPE_WIDTH
    paint met4
    label $name FreeSans 0.25u -met4
    port make
    port use [expr {$name eq "VGND" ? "ground" : "power"}]
    port class bidirectional
    port connections n s e w
}

foreach {name x} $POWER_STRIPES {
    puts "Drawing power stripe $name at $x"
    draw_power_stripe $name $x
}

save ${TOP_LEVEL_CELL}.mag
file mkdir gds
gds write gds/${TOP_LEVEL_CELL}.gds
file mkdir lef
lef write lef/${TOP_LEVEL_CELL}.lef -hide -pinonly
