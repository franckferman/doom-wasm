# TODO

## Son

- [ ] Implementer le decodage des sons DMX (PCM 8-bit) dans `i_sound.c` et les jouer via Web Audio API
- [ ] Musique MUS/MIDI : integrer un synthetiseur OPL en JS (ex: OPL3 emulator) pour la musique in-game
- [ ] Exporter les fonctions audio depuis le WASM (callbacks pour play/stop/volume)

## Support souris

- [ ] Ajouter `reportMouseMotion` dans les exports WASM (`src/doom_wasm.c`)
- [ ] Connecter le code existant dans `i_input.c` pour le mouvement de camera
- [ ] Pointer Lock API dans l'exemple browser pour capturer la souris

## Sauvegarde

- [ ] Implementer `gameSaving.sizeOfSaveGame`, `readSaveGame`, `writeSaveGame` avec `localStorage`
- [ ] Sauvegarder/restaurer la progression entre les sessions navigateur

## Performance

- [ ] Optimiser la copie du framebuffer (swap R/B cote WASM au lieu du JS)
- [ ] Ou utiliser `SharedArrayBuffer` + `Uint8ClampedArray` pour eviter la copie
- [ ] Evaluer l'utilisation de WebGL pour le rendu au lieu de `putImageData`

## Chargement WAD externe

- [ ] Debugger l'API `wadSizes`/`readWads` avec numWads > 1 (crash "function signature mismatch")
- [ ] Ecrire des tests unitaires sur l'ecriture memoire WASM (pointeurs, grow, buffer detach)
- [ ] Supporter le chargement de PWADs a runtime sans recompilation

## Plein ecran

- [ ] Bouton fullscreen dans l'exemple browser (Fullscreen API)
- [ ] Adapter la resolution du canvas dynamiquement au resize

## Mobile

- [ ] Touch controls : joystick virtuel + boutons (tirer, ouvrir, courir)
- [ ] Mapping touch events > reportKeyDown/reportKeyUp
- [ ] Detecter mobile et afficher les controles automatiquement

## Divers

- [ ] CI/CD : GitHub Actions pour build automatique + release du doom.wasm
- [ ] Pre-built release sur GitHub (doom.wasm + doom-patched.wasm)
