# Changelog

Changes from upstream [jacobenget/doom.wasm](https://github.com/jacobenget/doom.wasm).

## Build System

- Added `Makefile` wrapper around upstream build system (`Makefile.build`)
- New targets: `build-patched`, `serve`, `patch`, `unpatch`, `check`, `distclean`
- `make serve` builds and serves the browser example on localhost

## Patches

- `scripts/patch-autostart.sh`: optional apply/revert patch to skip title/menu screens and auto-start E1M1 on Hurt Me Plenty difficulty
- Source code is unpatched by default

## Browser Example

- Fullscreen canvas (`100vw` x `100vh`) with `object-fit: contain`
- Pixel-perfect scaling (`image-rendering: pixelated`)
- Dark background
- Auto-focus on load and click
- Visual dimming when canvas loses focus (instead of opacity change)

## Documentation

- Complete README with interface reference, controls, build system docs, project structure
- CHANGELOG.md (this file)
- Credits section with links to all upstream projects
