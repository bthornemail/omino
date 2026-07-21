CC ?= cc
CFLAGS ?= -std=c99 -Wall -Wextra -pedantic
LDFLAGS ?= -lm

BUILD_DIR := build
TARGET := $(BUILD_DIR)/omnicron-coproduct-partition
SRC := src/omnicron-coproduct-partition.c

VIEW_DIR := native-views/eal-logos-nomos-pathos
VIEW_FILES := $(VIEW_DIR)/index.html $(VIEW_DIR)/canvas.canvas $(VIEW_DIR)/dot-notation.md

.PHONY: all run views view-path clean

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TARGET): $(SRC) | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(SRC) $(LDFLAGS) -o $@

run: $(TARGET)
	./$(TARGET)

views: $(VIEW_FILES)
	@for file in $(VIEW_FILES); do test -r $$file || exit 1; done
	@printf '%s\n' "Native views verified: $(VIEW_DIR)"

view-path:
	@printf '%s\n' "$(CURDIR)/$(VIEW_DIR)/index.html"

clean:
	rm -f $(TARGET)
