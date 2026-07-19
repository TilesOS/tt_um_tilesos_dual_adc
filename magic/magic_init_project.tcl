# SPDX-License-Identifier: Apache-2.0
# Adapted from TinyTapeout/tt-support-tools (Uri Shaked) for tt_um_tilesos_dual_adc.
# Initializes a Magic project for the 1.8V 2x2 analog template and draws the
# VDPWR/VGND power stripes (met4). Run this ONCE to create the .mag, then draw
# your circuits inside the top cell.
#
# Usage (inside IIC-OSIC-TOOLS, from the project root, with sky130A selected):
#   1) Ensure def/tt_analog_2x2.def exists  (see def/README.md to fetch it).
#   2) magic -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc
#   3) In Magic's tcl console:  source magic/magic_init_project.tcl

# ---- settings for this design ----
set TOP_LEVEL_CELL     tt_um_tilesos_dual_adc
set TEMPLATE_FILE      def/tt_analog_2x2.def
set POWER_STRIPE_WIDTH 2um                 ;# minimum allowed is 1.2um

# Power stripes: NET name, x position (met4 vertical). 1.8V design -> VDPWR + VGND only.
set POWER_STRIPES {
    VDPWR 1um
    VGND  4um
}
# 1.8V design: do NOT add VAPWR. (If you ever switch to the _3v3 template, add: lappend POWER_STRIPES VAPWR 7um)

# ---- read pin positions from the template ----
def read $TEMPLATE_FILE
cellname rename tt_um_template $TOP_LEVEL_CELL

# ---- draw the power stripes ----
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

# ---- save + export (hierarchical: do NOT flatten the .mag) ----
save ${TOP_LEVEL_CELL}.mag
file mkdir gds
gds write gds/${TOP_LEVEL_CELL}.gds
file mkdir lef
lef write lef/${TOP_LEVEL_CELL}.lef -hide -pinonly
