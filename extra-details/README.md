# Extra design details

This directory contains project-development material that is useful while
designing the analog macro but is not part of the standard Tiny Tapeout
submission scaffold.

- [`design-notes.md`](design-notes.md) records unresolved electrical and
  verification decisions.
- [`def/README.md`](def/README.md) explains how to obtain the exact SKY130 2x2
  analog DEF template.
- [`magic/magic_init_project.tcl`](magic/magic_init_project.tcl) initializes a
  Magic layout from that template and creates the required power ports.

Run the Magic script from the repository root so its paths resolve correctly.
