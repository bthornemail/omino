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

.PHONY: all run test test-strict test-sanitize test-conformance test-golden views html canvas dot svg verilog-test clock-crosscheck check view-path clean dist

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

test-conformance: test-golden views canvas dot

test-golden: $(TARGET) $(GOLDEN_RUNTIME) | $(TEST_TMP_DIR)
	./$(TARGET) > $(RUNTIME_ACTUAL)
	@cmp -s $(GOLDEN_RUNTIME) $(RUNTIME_ACTUAL) || { diff -u $(GOLDEN_RUNTIME) $(RUNTIME_ACTUAL); exit 1; }
	@printf '%s\n' "Golden runtime output matches: $(GOLDEN_RUNTIME)"

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

verilog-test:
	@printf '%s\n' "SKIP: optional Verilog backend is not integrated yet"

clock-crosscheck:
	@printf '%s\n' "SKIP: clock cross-check vectors are not implemented yet"

check: test-strict test test-sanitize test-conformance

view-path:
	@printf '%s\n' "$(CURDIR)/$(VIEW_DIR)/index.html"

clean:
	rm -f $(TARGET)
	rm -rf $(TEST_TMP_DIR)
	rm -rf $(SVG_DIR)

dist: check
	@printf '%s\n' "SKIP: dist packaging is not implemented yet"
