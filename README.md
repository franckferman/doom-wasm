# doom-wasm

Doom (1993) compiled to WebAssembly. Runs natively in any browser with just a `<canvas>` element.

Fork of [jacobenget/doom.wasm](https://github.com/jacobenget/doom.wasm), built on top of [doomgeneric](https://github.com/ozkl/doomgeneric).

- Minimal WASM interface: 10 imports, 4 exports (surface area of 14 functions)
- Doom shareware Episode 1 (DOOM1.WAD) embedded in the binary
- Optional auto-start patch to skip menus and launch directly into gameplay
- Improved browser example with fullscreen canvas and pixel-perfect scaling
- Wrapper Makefile with build, serve, patch, and check targets

## Quick Start

### Build from Source

**Requirements**: Docker, Python 3, Git, curl

```bash
make                    # build doom.wasm (default, with menus)
make build-patched      # build with autostart (skip menus, direct E1M1)
make serve              # build + serve browser example on localhost:8080
```

First build takes ~10 minutes (Binaryen compiles from source). Subsequent builds ~2 minutes.

Output: `build/doom.wasm`

### Autostart Patch

Skip title/menu screens and launch directly into Episode 1, Map 1 (Hurt Me Plenty difficulty):

```bash
make patch              # apply autostart
make unpatch            # revert to default menus
make check              # show current patch state
```

### All Makefile Targets

```bash
make                    # build doom.wasm (default menus)
make build-patched      # build with autostart patch
make serve              # build + serve browser example
make patch              # apply autostart patch
make unpatch            # revert autostart patch
make check              # show build status and patch state
make clean              # clean build artifacts
make distclean          # remove everything (build + dev envs)
```

## WASM Interface

The module exposes a minimal interface of 14 functions, keeping integration simple.

### Imports (host provides)

| Module | Function | Signature | Description |
|--------|----------|-----------|-------------|
| `loading` | `onGameInit` | `(i32, i32) -> ()` | Called with framebuffer width and height |
| `loading` | `wadSizes` | `(i32, i32) -> ()` | Report WAD count and total byte size (no-op = use embedded shareware) |
| `loading` | `readWads` | `(i32, i32) -> ()` | Copy WAD data into WASM memory |
| `ui` | `drawFrame` | `(i32) -> ()` | New frame ready: pointer to ARGB pixel buffer |
| `runtimeControl` | `timeInMilliseconds` | `() -> (i64)` | Current time in milliseconds (BigInt) |
| `console` | `onInfoMessage` | `(i32, i32) -> ()` | Info message from engine (pointer, length) |
| `console` | `onErrorMessage` | `(i32, i32) -> ()` | Error message from engine (pointer, length) |
| `gameSaving` | `sizeOfSaveGame` | `(i32) -> (i32)` | Size of save data for a given slot |
| `gameSaving` | `readSaveGame` | `(i32, i32) -> (i32)` | Read save game data from slot |
| `gameSaving` | `writeSaveGame` | `(i32, i32, i32) -> (i32)` | Write save game data to slot |

### Exports (host calls)

| Function | Signature | Description |
|----------|-----------|-------------|
| `initGame` | `() -> ()` | Initialize the engine |
| `tickGame` | `() -> ()` | Advance one game frame (call at 35 FPS) |
| `reportKeyDown` | `(i32) -> ()` | Report a key press |
| `reportKeyUp` | `(i32) -> ()` | Report a key release |

### Exported Key Constants

`KEY_LEFTARROW`, `KEY_RIGHTARROW`, `KEY_UPARROW`, `KEY_DOWNARROW`, `KEY_FIRE`, `KEY_USE`, `KEY_SHIFT`, `KEY_TAB`, `KEY_ESCAPE`, `KEY_ENTER`, `KEY_BACKSPACE`, `KEY_ALT`, `KEY_STRAFE_L`, `KEY_STRAFE_R`

## Controls

| Key | Action |
|-----|--------|
| Arrow keys | Move and turn |
| Ctrl | Fire weapon |
| Space | Open doors, activate switches |
| Shift | Run |
| Alt + arrows | Strafe (lateral movement) |
| 1-7 | Switch weapon |
| Tab | Automap |
| Esc | Menu |

## Examples

| Example | Description | Runtime |
|---------|-------------|---------|
| `examples/browser/` | Minimal browser implementation (fullscreen canvas) | Any modern browser |
| `examples/native/` | Native implementation with SDL + Wasmtime | C compiler, SDL2 |
| `examples/python/` | Python implementation with PyGame + Wasmtime | Python 3, PyGame |

Each example supports custom WAD loading and game saving (except the browser example which demonstrates the minimal integration).

## Project Structure

```
doom-wasm/
  Makefile              # wrapper with build/serve/patch targets
  Makefile.build        # upstream build system (Docker + WASI SDK + Binaryen)
  scripts/
    patch-autostart.sh  # apply/revert autostart patch
  src/                  # WASM-specific C source (doom_wasm.c, imports bridge)
  doomgeneric/          # doomgeneric engine (portable Doom source)
  utils/                # build utilities (WAD embedding, interface printing)
  examples/             # browser, native, and python examples
  CHANGELOG.md          # changes from upstream
  LICENSE               # AGPL-3.0
```

## Build System

The build pipeline:

1. **WAD download**: Doom shareware WAD from [doomwiki.org](https://doomwiki.org/wiki/DOOM1.WAD)
2. **WAD embedding**: Python script converts WAD to C source (compiled into the binary)
3. **WASM compilation**: [WASI SDK](https://github.com/WebAssembly/wasi-sdk) via Docker
4. **Post-processing**: [Binaryen](https://github.com/WebAssembly/binaryen) tools merge WASI trampolines, deduplicate exports, and add key constants

## License

- Doom source code: GNU GPL v2 ([id Software](https://github.com/id-Software/DOOM))
- doomgeneric: MIT ([ozkl](https://github.com/ozkl/doomgeneric))
- doom.wasm upstream: AGPL-3.0 ([jacobenget](https://github.com/jacobenget/doom.wasm))
- This fork: AGPL-3.0
- DOOM1.WAD (shareware): Freely distributable by id Software

## Credits

- [id Software](https://github.com/id-Software/DOOM) for the original Doom source code
- [ozkl/doomgeneric](https://github.com/ozkl/doomgeneric) for the portable Doom abstraction layer
- [jacobenget/doom.wasm](https://github.com/jacobenget/doom.wasm) for the minimal WASM compilation approach
