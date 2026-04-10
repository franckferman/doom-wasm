# TODO

## Audio

- [ ] Implement DMX sound decoding (PCM 8-bit) in `i_sound.c` and play via Web Audio API
- [ ] MUS/MIDI music: integrate an OPL synthesizer in JS (e.g. OPL3 emulator) for in-game music
- [ ] Export audio functions from WASM (callbacks for play/stop/volume)

## Mouse Support

- [ ] Add `reportMouseMotion` to WASM exports (`src/doom_wasm.c`)
- [ ] Connect existing code in `i_input.c` for camera movement
- [ ] Pointer Lock API in browser example for mouse capture

## Save System

- [ ] Implement `gameSaving.sizeOfSaveGame`, `readSaveGame`, `writeSaveGame` with `localStorage`
- [ ] Persist game progress across browser sessions

## Performance

- [ ] Optimize framebuffer copy (R/B swap on WASM side instead of JS)
- [ ] Evaluate `SharedArrayBuffer` + `Uint8ClampedArray` to avoid JS copy
- [ ] Evaluate WebGL rendering instead of `putImageData`

## External WAD Loading

- [ ] Debug `wadSizes`/`readWads` API with numWads > 1 (crashes with "function signature mismatch")
- [ ] Write unit tests for WASM memory writes (pointers, grow, buffer detach)
- [ ] Support runtime PWAD loading without recompilation

## Fullscreen

- [ ] Fullscreen button in browser example (Fullscreen API)
- [ ] Dynamic canvas resolution on window resize

## Mobile

- [ ] Touch controls: virtual joystick + buttons (fire, open, run)
- [ ] Map touch events to reportKeyDown/reportKeyUp
- [ ] Auto-detect mobile and display controls

## CI/CD

- [ ] GitHub Actions for automated build + release
- [ ] Pre-built releases on GitHub (doom.wasm + doom-patched.wasm)
