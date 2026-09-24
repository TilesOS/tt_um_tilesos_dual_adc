# Official SKY130 2x2 analog DEF template

The pin positions are integration-critical and must match Tiny Tapeout's
official template exactly. Do not recreate or hand-edit them.

This 1.8 V design uses:

    tt_analog_2x2.def

The repository includes a copy fetched from `tt-support-tools` commit
`d65690eeb1d4afd26aef795c805a23d9d9daf9d1`, with SHA-256:

    c9bf60e875dc86e730424e7af724878977aec59586832a9b8fc937c2cd65c86f

The production layout was closed against this pinned copy. Do not overwrite it
with an unreviewed upstream revision. To audit the current upstream template,
download it separately from the repository root with:

```bash
curl -fsSLo /tmp/tt_analog_2x2.current.def \\
  https://raw.githubusercontent.com/TinyTapeout/tt-support-tools/main/tech/sky130A/def/analog/tt_analog_2x2.def
sha256sum /tmp/tt_analog_2x2.current.def extra-details/def/tt_analog_2x2.def
```

Compare the checksums and upstream history before deliberately accepting any
change and reopening physical signoff. Do not use `tt_analog_2x2_3v3.def`:
this project uses only VDPWR and sets `uses_vapwr: false`.

Important SKY130 properties:

- Die area: 334.88 x 225.76 um.
- Signal pins are on met4.
- Only `ua[0]` and `ua[1]` are purchased/used even though the physical template
  contains all eight `ua` ports.
- Power ports must be vertical met4 stripes at least 1.2 um wide, starting
  within 10 um of the bottom and ending within 10 um of the top.
- User geometry must not use met5.
