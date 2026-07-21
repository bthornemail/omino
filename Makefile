CC ?= cc
CFLAGS ?= -std=c99 -Wall -Wextra -pedantic
LDFLAGS ?= -lm

BUILD_DIR := build
TARGET := $(BUILD_DIR)/omnicron-coproduct-partition
SRC := src/omnicron-coproduct-partition.c

TEST_TMP_DIR := tests/tmp
GOLDEN_RUNTIME := tests/golden/c-runtime-output.txt
RUNTIME_ACTUAL := $(TEST_TMP_DIR)/c-runtime-output.txt

VIEW_DIR := public
VIEW_FILES := $(VIEW_DIR)/index.html $(VIEW_DIR)/canvas.canvas $(VIEW_DIR)/dot-notation.md
CANVAS_FILES := $(VIEW_DIR)/canvas.canvas $(sort $(wildcard views/canvas/examples/*.canvas))
DOT_DIR := views/dot/templates
DOT_FILES := $(sort $(wildcard $(DOT_DIR)/*.dot))
SVG_DIR := views/generated/svg
VERILOG_DIR := verilog
VERILOG_CORE := $(VERILOG_DIR)/eal_lambda_canon_core.v
VERILOG_TB := $(VERILOG_DIR)/tb_eal_lambda_canon_core.v
VERILOG_OUT := $(TEST_TMP_DIR)/eal_lambda_canon_core.vvp
LAMBDA_CORE_VECTORS := vectors/eal-lambda-canon-core.jsonl
RECOVERY_VECTORS := vectors/quasigroup-recovery.jsonl
RECOVERY_TEST := $(TEST_TMP_DIR)/recovery_conformance
LAMBDA_TYPES_DIR := tests/lambda-types
LAMBDA_TYPES_BUILD_DIR := $(TEST_TMP_DIR)/lambda-types
LAMBDA_TYPES_MAIN := $(LAMBDA_TYPES_DIR)/Main.hs
LAMBDA_TYPES_CORE := $(LAMBDA_TYPES_DIR)/EmergentAxialLisp/LambdaCanonTypeCore.hs
ESP32_EXAMPLE := examples/esp32/esp32_omi_core.c
ESP32_TEST := $(TEST_TMP_DIR)/esp32_omi_core_test
RUNTIME_LOCK_TEST := $(TEST_TMP_DIR)/runtime_lock_conformance

.PHONY: all run test test-strict test-sanitize test-conformance test-golden test-recovery test-lambda-types test-esp32 test-runtime-lock views html canvas dot svg verilog-test clock-crosscheck check view-path clean dist

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TARGET): $(SRC) | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(SRC) $(LDFLAGS) -o $@

run: $(TARGET)
	./$(TARGET)

$(TEST_TMP_DIR):
	mkdir -p $(TEST_TMP_DIR)

test: test-golden views

test-strict: clean all

test-sanitize: $(SRC) | $(BUILD_DIR) $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) -fsanitize=address,undefined $(SRC) $(LDFLAGS) -o $(TEST_TMP_DIR)/omnicron-coproduct-partition-sanitize
	ASAN_OPTIONS=detect_leaks=0 $(TEST_TMP_DIR)/omnicron-coproduct-partition-sanitize >/dev/null

test-conformance: test-golden test-recovery test-lambda-types test-esp32 test-runtime-lock views canvas dot

test-golden: $(TARGET) $(GOLDEN_RUNTIME) | $(TEST_TMP_DIR)
	./$(TARGET) > $(RUNTIME_ACTUAL)
	@cmp -s $(GOLDEN_RUNTIME) $(RUNTIME_ACTUAL) || { diff -u $(GOLDEN_RUNTIME) $(RUNTIME_ACTUAL); exit 1; }
	@printf '%s\n' "Golden runtime output matches: $(GOLDEN_RUNTIME)"

$(RECOVERY_TEST): tests/recovery/recovery_conformance.c $(SRC) $(RECOVERY_VECTORS) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/recovery/recovery_conformance.c $(LDFLAGS) -o $@

test-recovery: $(RECOVERY_TEST)
	$(RECOVERY_TEST)

test-lambda-types: $(LAMBDA_TYPES_MAIN) $(LAMBDA_TYPES_CORE) | $(TEST_TMP_DIR)
	@if command -v ghc >/dev/null 2>&1; then \
		mkdir -p $(LAMBDA_TYPES_BUILD_DIR); \
		ghc -fforce-recomp -i$(LAMBDA_TYPES_DIR) -outputdir $(LAMBDA_TYPES_BUILD_DIR) -o $(LAMBDA_TYPES_BUILD_DIR)/lambda-canon-types $(LAMBDA_TYPES_MAIN) >/dev/null; \
		$(LAMBDA_TYPES_BUILD_DIR)/lambda-canon-types; \
		if ghc -fforce-recomp -fno-code -i$(LAMBDA_TYPES_DIR) -outputdir $(LAMBDA_TYPES_BUILD_DIR) $(LAMBDA_TYPES_DIR)/InvalidMuxBand.hs >/dev/null 2>$(LAMBDA_TYPES_BUILD_DIR)/invalid-mux.err; then \
			printf '%s\n' "FAIL: invalid mux band compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(LAMBDA_TYPES_DIR) -outputdir $(LAMBDA_TYPES_BUILD_DIR) $(LAMBDA_TYPES_DIR)/InvalidObserverBoundary.hs >/dev/null 2>$(LAMBDA_TYPES_BUILD_DIR)/invalid-observer.err; then \
			printf '%s\n' "FAIL: invalid observer boundary compiled unexpectedly"; exit 1; \
		fi; \
		printf '%s\n' "Lambda Canon type-level rejection checks passed"; \
	else \
		printf '%s\n' "SKIP: ghc not available for Lambda Canon type-level checks"; \
	fi

$(ESP32_TEST): tests/esp32/esp32_omi_core_test.c $(ESP32_EXAMPLE) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/esp32/esp32_omi_core_test.c -o $@

test-esp32: $(ESP32_TEST)
	$(ESP32_TEST)

$(RUNTIME_LOCK_TEST): tests/runtime-lock/runtime_lock_conformance.c $(SRC) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/runtime-lock/runtime_lock_conformance.c $(LDFLAGS) -o $@

test-runtime-lock: $(RUNTIME_LOCK_TEST)
	$(RUNTIME_LOCK_TEST)

views: $(VIEW_FILES)
	@for file in $(VIEW_FILES); do test -r $$file || exit 1; done
	@printf '%s\n' "Native views verified: $(VIEW_DIR)"

html: $(VIEW_DIR)/index.html
	@printf '%s\n' "HTML projection verified: $<"

canvas: $(CANVAS_FILES)
	@if command -v jq >/dev/null 2>&1; then \
		for file in $(CANVAS_FILES); do jq empty $$file || exit 1; jq -e '.nodes | all(has("omi"))' $$file >/dev/null || exit 1; done; \
		printf '%s\n' "JSON Canvas files verified"; \
	else \
		printf '%s\n' "SKIP: jq not available for JSON Canvas validation"; \
	fi

dot: $(DOT_FILES)
	@if command -v dot >/dev/null 2>&1; then \
		for file in $(DOT_FILES); do dot -Tdot $$file >/dev/null || exit 1; done; \
		printf '%s\n' "DOT templates verified: $(DOT_DIR)"; \
	else \
		printf '%s\n' "SKIP: graphviz dot not available for DOT validation"; \
	fi

svg: dot
	@if command -v dot >/dev/null 2>&1; then \
		mkdir -p $(SVG_DIR); \
		for file in $(DOT_FILES); do base=$$(basename $$file .dot); dot -Tsvg $$file -o $(SVG_DIR)/$$base.svg || exit 1; done; \
		printf '%s\n' "SVG projections generated: $(SVG_DIR)"; \
	else \
		printf '%s\n' "SKIP: graphviz dot not available for SVG generation"; \
	fi

verilog-test: $(VERILOG_CORE) $(VERILOG_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(VERILOG_OUT) $(VERILOG_CORE) $(VERILOG_TB); \
		vvp $(VERILOG_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional Verilog backend"; \
	fi

clock-crosscheck: $(LAMBDA_CORE_VECTORS) verilog-test
	@if command -v jq >/dev/null 2>&1; then \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and .x_omi and .y_imo and .character_token and has("received_omnion") and .parabolic_eval and has("is_void_centroid") and has("observer_boundary") and has("is_admissible")' >/dev/null || exit 1; done < $(LAMBDA_CORE_VECTORS); \
		printf '%s\n' "Lambda Canon core vectors verified: $(LAMBDA_CORE_VECTORS)"; \
	else \
		printf '%s\n' "SKIP: jq not available for vector validation"; \
	fi

check: test-strict test test-sanitize test-conformance

view-path:
	@printf '%s\n' "$(CURDIR)/$(VIEW_DIR)/index.html"

clean:
	rm -f $(TARGET)
	rm -rf $(TEST_TMP_DIR)
	rm -rf $(SVG_DIR)

dist: check
	@printf '%s\n' "SKIP: dist packaging is not implemented yet"
