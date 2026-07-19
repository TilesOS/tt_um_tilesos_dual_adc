# DEF pin template — fetch from upstream (do not hand-edit)

The pin positions here are **load-bearing**: they must match Tiny Tapeout's
template exactly, or your pads won't line up and the design is rejected (and a
wrong coordinate that slips through is a fab-killer). So this file is pulled
verbatim from upstream rather than copied by hand.

For a **1.8V** design (our case, `uses_vapwr: false`) you need:

    tt_analog_2x2.def

Fetch it on your Ubuntu desktop (GitHub works there; the sandbox that scaffolded
this repo was network-restricted):

```bash
cd def
curl -fsSLO https://raw.githubusercontent.com/TinyTapeout/tt-support-tools/main/tech/sky130A/def/analog/tt_analog_2x2.def
sha256sum tt_analog_2x2.def   # note the hash; re-verify before submission
```

Or browse: https://github.com/TinyTapeout/tt-support-tools/tree/main/tech/sky130A/def/analog

**Do not** use `tt_analog_2x2_3v3.def` — that's for the 3.3V (VAPWR) rail, which
we deliberately are not using (see ../DECISIONS.md #1).

Key facts about this template (verified 18 Jul 2026):
- DIEAREA: 334.88 x 225.76 um (2x2)
- Signal pins on met4; `ua[0]`..`ua[7]` present but only `ua[0]`,`ua[1]` bond (we paid for 2)
- Power comes from the met4 stripes you draw (see ../magic/magic_init_project.tcl), not from the DEF
- Forbidden layer: **met5** (TT's power grid)
