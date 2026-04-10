# ============================================================
# doom-wasm - Doom (1993) compiled to WebAssembly
# Fork of jacobenget/doom.wasm
# ============================================================

WASM_OUTPUT  := build/doom.wasm
EXAMPLE_DIR  := examples/browser
SERVE_PORT   := 8080

.PHONY: all build build-patched serve patch unpatch check clean distclean help

## Build doom.wasm (default menus)
all: build

## Build with upstream Makefile
build:
	@$(MAKE) -f Makefile.build doom
	@echo "==> Build complete: $$(ls -lh $(WASM_OUTPUT) 2>/dev/null | awk '{print $$5}') "

## Build with autostart patch (skip menus, direct E1M1)
build-patched: patch build

## Apply autostart patch
patch:
	@bash scripts/patch-autostart.sh apply

## Revert autostart patch
unpatch:
	@bash scripts/patch-autostart.sh revert

## Serve browser example locally
serve: build
	@echo "==> Copying doom.wasm to example..."
	@mkdir -p $(EXAMPLE_DIR)/assets
	@cp $(WASM_OUTPUT) $(EXAMPLE_DIR)/assets/doom.wasm
	@echo "==> http://localhost:$(SERVE_PORT)/$(EXAMPLE_DIR)/doom.html"
	@python3 -m http.server $(SERVE_PORT)

## Verify build output
check:
	@if [ -f "$(WASM_OUTPUT)" ]; then \
		echo "==> $(WASM_OUTPUT): $$(ls -lh $(WASM_OUTPUT) | awk '{print $$5}')"; \
		echo "==> Type: $$(file $(WASM_OUTPUT) | cut -d: -f2)"; \
	else \
		echo "==> Not built yet. Run: make build"; \
	fi
	@echo "==> Autostart patch:"
	@grep "autostart = " doomgeneric/src/d_main.c | head -1 | xargs echo " "

## Clean build artifacts
clean:
	@$(MAKE) -f Makefile.build clean
	@echo "==> Clean OK"

## Remove everything (build + dev envs + binaryen)
distclean:
	@$(MAKE) -f Makefile.build clean 2>/dev/null || true
	@$(MAKE) -f Makefile.build dev-clean 2>/dev/null || true
	@rm -rf build .binaryen .dev_virtualenvs
	@echo "==> Distclean OK"

## Help
help:
	@echo ""
	@echo "  doom-wasm"
	@echo "  ========="
	@echo ""
	@echo "  make              Build doom.wasm (default menus)"
	@echo "  make build-patched  Build with autostart (skip menus)"
	@echo "  make serve        Build + serve browser example"
	@echo "  make patch        Apply autostart patch"
	@echo "  make unpatch      Revert autostart patch"
	@echo "  make check        Show build status + patch state"
	@echo "  make clean        Clean build artifacts"
	@echo "  make distclean    Remove everything"
	@echo ""
