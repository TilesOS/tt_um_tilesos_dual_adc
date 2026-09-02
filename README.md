![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg)

# Dual-Path Noise-Shaping ADC

- [Read the project documentation](docs/info.md)
- [Read the auxiliary design and layout notes](extra-details/README.md)

## What is Tiny Tapeout?

Tiny Tapeout is an educational project that makes it easier and cheaper to
manufacture a custom chip.

To learn more, visit https://tinytapeout.com.

## Analog projects

This is a SKY130 analog/custom-GDS project targeting Tiny Tapeout SKY 26c. For
the applicable interface and layout rules, see the
[analog specifications](https://tinytapeout.com/specs/analog/).

## Repository status

The dual-ADC transistor-level design and 2x2 custom layout are physically
closed. Production GDS and 53-pin LEF have been regenerated and round-tripped;
the pinned Tiny Tapeout precheck and repository closeout are the remaining
local tapeout steps.

## Enable GitHub Actions to build the results page

- [Enabling GitHub Pages](https://tinytapeout.com/faq/#my-github-action-is-failing-on-the-pages-part)

## Resources

- [Tiny Tapeout FAQ](https://tinytapeout.com/faq/)
- [Tiny Tapeout Discord](https://tinytapeout.com/discord)
- [SKY analog template](https://github.com/TinyTapeout/ttsky-analog-template)

## What next?

- Run the pinned precheck and repository documentation checks.
- Push the final GDS/LEF/metadata commit and confirm GitHub Actions are green.
- Submit the latest green revision through https://app.tinytapeout.com/.
