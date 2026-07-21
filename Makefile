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
OCTAHEDRAL_ROUTER := $(VERILOG_DIR)/eal_octahedral_face_router.v
OCTAHEDRAL_ROUTER_TB := $(VERILOG_DIR)/tb_eal_octahedral_face_router.v
OCTAHEDRAL_ROUTER_OUT := $(TEST_TMP_DIR)/eal_octahedral_face_router.vvp
METATRON_SCRIBE := $(VERILOG_DIR)/metatron_incidence_scribe.v
METATRON_SCRIBE_TB := $(VERILOG_DIR)/tb_metatron_incidence_scribe.v
METATRON_SCRIBE_OUT := $(TEST_TMP_DIR)/metatron_incidence_scribe.vvp
OMNICRON_BQF_RESOLVER := $(VERILOG_DIR)/omnicron_bqf_resolver.v
OMNICRON_BQF_RESOLVER_TB := $(VERILOG_DIR)/tb_omnicron_bqf_resolver.v
OMNICRON_BQF_RESOLVER_OUT := $(TEST_TMP_DIR)/omnicron_bqf_resolver.vvp
FANO_SLOT_SCHEDULER := $(VERILOG_DIR)/fano_slot_scheduler.v
FANO_SLOT_SCHEDULER_TB := $(VERILOG_DIR)/tb_fano_slot_scheduler.v
FANO_SLOT_SCHEDULER_OUT := $(TEST_TMP_DIR)/fano_slot_scheduler.vvp
META_ASSEMBLER := $(VERILOG_DIR)/eal_meta_assembler.v
META_ASSEMBLER_TB := $(VERILOG_DIR)/tb_eal_meta_assembler.v
META_ASSEMBLER_OUT := $(TEST_TMP_DIR)/eal_meta_assembler.vvp
BACKPLANE_MONITOR := $(VERILOG_DIR)/backplane_interlock_monitor.v
BACKPLANE_MONITOR_TB := $(VERILOG_DIR)/tb_backplane_interlock_monitor.v
BACKPLANE_MONITOR_OUT := $(TEST_TMP_DIR)/backplane_interlock_monitor.vvp
LAYER4_MULTIPLICITY := $(VERILOG_DIR)/eal_layer4_multiplicity_calc.v
LAYER4_MULTIPLICITY_TB := $(VERILOG_DIR)/tb_eal_layer4_multiplicity_calc.v
LAYER4_MULTIPLICITY_OUT := $(TEST_TMP_DIR)/eal_layer4_multiplicity_calc.vvp
METAMORPHIC_EXPORT_VALIDATOR := $(VERILOG_DIR)/eal_metamorphic_export_validator.v
METAMORPHIC_EXPORT_VALIDATOR_TB := $(VERILOG_DIR)/tb_eal_metamorphic_export_validator.v
METAMORPHIC_EXPORT_VALIDATOR_OUT := $(TEST_TMP_DIR)/eal_metamorphic_export_validator.vvp
VISUAL_MATRIX_PROJECTOR := $(VERILOG_DIR)/omino_visual_matrix_projector.v
VISUAL_MATRIX_PROJECTOR_TB := $(VERILOG_DIR)/tb_omino_visual_matrix_projector.v
VISUAL_MATRIX_PROJECTOR_OUT := $(TEST_TMP_DIR)/omino_visual_matrix_projector.vvp
LAGRANGE_SPACE_RESOLVER := $(VERILOG_DIR)/eal_lagrange_space_resolver.v
LAGRANGE_SPACE_RESOLVER_TB := $(VERILOG_DIR)/tb_eal_lagrange_space_resolver.v
LAGRANGE_SPACE_RESOLVER_OUT := $(TEST_TMP_DIR)/eal_lagrange_space_resolver.vvp
LAMBDA_CORE_VECTORS := vectors/eal-lambda-canon-core.jsonl
OCTAHEDRAL_ROUTER_VECTORS := vectors/octahedral-face-router.jsonl
METATRON_SCRIBE_VECTORS := vectors/metatron-incidence-scribe.jsonl
OMNICRON_BQF_RESOLVER_VECTORS := vectors/omnicron-bqf-resolver.jsonl
FANO_SLOT_SCHEDULER_VECTORS := vectors/fano-slot-scheduler.jsonl
META_ASSEMBLER_VECTORS := vectors/eal-meta-assembler.jsonl
BACKPLANE_MONITOR_VECTORS := vectors/backplane-interlock-monitor.jsonl
LAYER4_MULTIPLICITY_VECTORS := vectors/layer4-multiplicity-calc.jsonl
METAMORPHIC_EXPORT_VECTORS := vectors/metamorphic-export-validator.jsonl
VISUAL_MATRIX_VECTORS := vectors/visual-matrix-projector.jsonl
LAGRANGE_SPACE_VECTORS := vectors/lagrange-space-resolver.jsonl
RECOVERY_VECTORS := vectors/quasigroup-recovery.jsonl
RECOVERY_TEST := $(TEST_TMP_DIR)/recovery_conformance
ALGORITHMIC_LAWS_TEST := $(TEST_TMP_DIR)/algorithmic_laws_conformance
O_EXAMPLES := $(sort $(wildcard examples/o/*.o))
LAMBDA_TYPES_DIR := tests/lambda-types
LAMBDA_TYPES_BUILD_DIR := $(TEST_TMP_DIR)/lambda-types
LAMBDA_TYPES_MAIN := $(LAMBDA_TYPES_DIR)/Main.hs
LAMBDA_TYPES_CORE := $(LAMBDA_TYPES_DIR)/EmergentAxialLisp/LambdaCanonTypeCore.hs
OCTAHEDRAL_TYPES_DIR := tests/octahedral-types
OCTAHEDRAL_TYPES_BUILD_DIR := $(TEST_TMP_DIR)/octahedral-types
OCTAHEDRAL_TYPES_MAIN := $(OCTAHEDRAL_TYPES_DIR)/Main.hs
OCTAHEDRAL_TYPES_CORE := $(OCTAHEDRAL_TYPES_DIR)/EmergentAxialLisp/OctahedralTypeCore.hs
CANONICAL_TYPES_DIR := tests/canonical-types
CANONICAL_TYPES_BUILD_DIR := $(TEST_TMP_DIR)/canonical-types
CANONICAL_TYPES_MAIN := $(CANONICAL_TYPES_DIR)/Main.hs
CANONICAL_TYPES_CORE := $(CANONICAL_TYPES_DIR)/OmiImo/CanonicalResolverAuthorities.hs
META_COMPILER_TYPES_DIR := tests/meta-compiler-types
META_COMPILER_TYPES_BUILD_DIR := $(TEST_TMP_DIR)/meta-compiler-types
META_COMPILER_TYPES_MAIN := $(META_COMPILER_TYPES_DIR)/Main.hs
META_COMPILER_TYPES_CORE := $(META_COMPILER_TYPES_DIR)/EmergentAxialLisp/MetaCompilerCore.hs
CONFORMANCE_GUARDRAIL_TYPES_DIR := tests/conformance-guardrail-types
CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR := $(TEST_TMP_DIR)/conformance-guardrail-types
CONFORMANCE_GUARDRAIL_TYPES_MAIN := $(CONFORMANCE_GUARDRAIL_TYPES_DIR)/Main.hs
CONFORMANCE_GUARDRAIL_TYPES_CORE := $(CONFORMANCE_GUARDRAIL_TYPES_DIR)/Omino/ConformanceGuardrail.hs
LAYER4_TYPES_DIR := tests/layer4-types
LAYER4_TYPES_BUILD_DIR := $(TEST_TMP_DIR)/layer4-types
LAYER4_TYPES_MAIN := $(LAYER4_TYPES_DIR)/Main.hs
LAYER4_TYPES_CORE := $(LAYER4_TYPES_DIR)/EmergentAxialLisp/Layer4TetrahedronCore.hs
METAMORPHIC_TYPES_DIR := tests/metamorphic-types
METAMORPHIC_TYPES_BUILD_DIR := $(TEST_TMP_DIR)/metamorphic-types
METAMORPHIC_TYPES_MAIN := $(METAMORPHIC_TYPES_DIR)/Main.hs
METAMORPHIC_TYPES_CORE := $(METAMORPHIC_TYPES_DIR)/EmergentAxialLisp/MetamorphicCompilerCore.hs
LAGRANGE_TYPES_DIR := tests/lagrange-types
LAGRANGE_TYPES_BUILD_DIR := $(TEST_TMP_DIR)/lagrange-types
LAGRANGE_TYPES_MAIN := $(LAGRANGE_TYPES_DIR)/Main.hs
LAGRANGE_TYPES_CORE := $(LAGRANGE_TYPES_DIR)/EmergentAxialLisp/LagrangeSpaceTypeCore.hs
ESP32_EXAMPLE := examples/esp32/esp32_omi_core.c
ESP32_TEST := $(TEST_TMP_DIR)/esp32_omi_core_test
ESP32_GOSSIP_EXAMPLE := examples/esp32/esp32_p2p_gossip.c
ESP32_GOSSIP_TEST := $(TEST_TMP_DIR)/esp32_p2p_gossip_test
BOOT_ENVELOPE_EXAMPLE := examples/esp32/omi_boot_envelope.c
BOOT_ENVELOPE_TEST := $(TEST_TMP_DIR)/omi_boot_envelope_test
OMNICRON_EPISTEMIC_EXAMPLE := examples/esp32/omnicron_epistemic_core.c
OMNICRON_EPISTEMIC_TEST := $(TEST_TMP_DIR)/omnicron_epistemic_core_test
TCG_TARGET_HEADER := examples/tcg/tcg-target.h
TCG_TARGET_IMPL := examples/tcg/tcg-target.c.inc
RUNTIME_LOCK_TEST := $(TEST_TMP_DIR)/runtime_lock_conformance
MEDIA_BRIDGE_EXAMPLE := examples/media/omi_media_bridge.c
MEDIA_BRIDGE_TEST := $(TEST_TMP_DIR)/omi_media_bridge_test
METATRON_PRECLOSURE_EXAMPLE := examples/metatron/metatron_preclosure.c
METATRON_PRECLOSURE_TEST := $(TEST_TMP_DIR)/metatron_preclosure_test
BASE_METRIC_EXAMPLE := examples/radix/base_metric_seed_model.c
BASE_METRIC_TEST := $(TEST_TMP_DIR)/base_metric_seed_model_test
BINARY_EXPORT_EXAMPLE := examples/compiler/binary_export_verifier.c
BINARY_EXPORT_TEST := $(TEST_TMP_DIR)/binary_export_verifier_test

.PHONY: all run test test-strict test-sanitize test-conformance test-golden test-recovery test-algorithmic-laws test-o-lifecycle test-lambda-types test-octahedral-types test-canonical-types test-meta-compiler-types test-conformance-guardrail-types test-layer4-types test-metamorphic-types test-lagrange-types test-esp32 test-esp32-gossip test-boot-envelope test-omnicron-epistemic test-tcg-backend-spec test-runtime-lock test-media-bridge test-metatron-preclosure test-base-metric test-binary-export views html canvas dot svg verilog-test octahedral-router-test metatron-scribe-test omnicron-bqf-test fano-slot-test meta-assembler-test backplane-monitor-test layer4-multiplicity-test metamorphic-export-test visual-matrix-test lagrange-space-test clock-crosscheck check view-path clean dist

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

test-conformance: test-golden test-recovery test-algorithmic-laws test-o-lifecycle test-lambda-types test-octahedral-types test-canonical-types test-meta-compiler-types test-conformance-guardrail-types test-layer4-types test-metamorphic-types test-lagrange-types test-esp32 test-esp32-gossip test-boot-envelope test-omnicron-epistemic test-tcg-backend-spec test-runtime-lock test-base-metric test-media-bridge test-metatron-preclosure test-binary-export views canvas dot

test-golden: $(TARGET) $(GOLDEN_RUNTIME) | $(TEST_TMP_DIR)
	./$(TARGET) > $(RUNTIME_ACTUAL)
	@cmp -s $(GOLDEN_RUNTIME) $(RUNTIME_ACTUAL) || { diff -u $(GOLDEN_RUNTIME) $(RUNTIME_ACTUAL); exit 1; }
	@printf '%s\n' "Golden runtime output matches: $(GOLDEN_RUNTIME)"

$(RECOVERY_TEST): tests/recovery/recovery_conformance.c $(SRC) $(RECOVERY_VECTORS) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/recovery/recovery_conformance.c $(LDFLAGS) -o $@

test-recovery: $(RECOVERY_TEST)
	$(RECOVERY_TEST)

$(ALGORITHMIC_LAWS_TEST): tests/algorithmic/algorithmic_laws_conformance.c | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/algorithmic/algorithmic_laws_conformance.c -o $@

test-algorithmic-laws: $(ALGORITHMIC_LAWS_TEST)
	$(ALGORITHMIC_LAWS_TEST)

test-o-lifecycle: docs/O-SOURCE-LIFECYCLE.md $(O_EXAMPLES)
	@rg -q 'attestation' docs/O-SOURCE-LIFECYCLE.md
	@for file in $(O_EXAMPLES); do rg -q 'attestation pending' $$file || exit 1; done
	@printf '%s\n' ".o source lifecycle examples verified"

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

test-octahedral-types: $(OCTAHEDRAL_TYPES_MAIN) $(OCTAHEDRAL_TYPES_CORE) | $(TEST_TMP_DIR)
	@if command -v ghc >/dev/null 2>&1; then \
		mkdir -p $(OCTAHEDRAL_TYPES_BUILD_DIR); \
		ghc -fforce-recomp -i$(OCTAHEDRAL_TYPES_DIR) -outputdir $(OCTAHEDRAL_TYPES_BUILD_DIR) -o $(OCTAHEDRAL_TYPES_BUILD_DIR)/octahedral-types $(OCTAHEDRAL_TYPES_MAIN) >/dev/null; \
		$(OCTAHEDRAL_TYPES_BUILD_DIR)/octahedral-types; \
		if ghc -fforce-recomp -fno-code -i$(OCTAHEDRAL_TYPES_DIR) -outputdir $(OCTAHEDRAL_TYPES_BUILD_DIR) $(OCTAHEDRAL_TYPES_DIR)/InvalidA080Face4.hs >/dev/null 2>$(OCTAHEDRAL_TYPES_BUILD_DIR)/invalid-a080-face4.err; then \
			printf '%s\n' "FAIL: invalid 0xA080 Face4 assignment compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(OCTAHEDRAL_TYPES_DIR) -outputdir $(OCTAHEDRAL_TYPES_BUILD_DIR) $(OCTAHEDRAL_TYPES_DIR)/InvalidRemoteInterface.hs >/dev/null 2>$(OCTAHEDRAL_TYPES_BUILD_DIR)/invalid-remote-interface.err; then \
			printf '%s\n' "FAIL: invalid remote interface assignment compiled unexpectedly"; exit 1; \
		fi; \
		printf '%s\n' "Octahedral type-level rejection checks passed"; \
	else \
		printf '%s\n' "SKIP: ghc not available for octahedral type-level checks"; \
	fi

test-canonical-types: $(CANONICAL_TYPES_MAIN) $(CANONICAL_TYPES_CORE) | $(TEST_TMP_DIR)
	@if command -v ghc >/dev/null 2>&1; then \
		mkdir -p $(CANONICAL_TYPES_BUILD_DIR); \
		ghc -fforce-recomp -i$(CANONICAL_TYPES_DIR) -outputdir $(CANONICAL_TYPES_BUILD_DIR) -o $(CANONICAL_TYPES_BUILD_DIR)/canonical-types $(CANONICAL_TYPES_MAIN) >/dev/null; \
		$(CANONICAL_TYPES_BUILD_DIR)/canonical-types; \
		if ghc -fforce-recomp -fno-code -i$(CANONICAL_TYPES_DIR) -outputdir $(CANONICAL_TYPES_BUILD_DIR) $(CANONICAL_TYPES_DIR)/InvalidTetragrammatronGnomonic.hs >/dev/null 2>$(CANONICAL_TYPES_BUILD_DIR)/invalid-tetragrammatron-gnomonic.err; then \
			printf '%s\n' "FAIL: invalid Tetragrammatron/Gnomonic witness compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(CANONICAL_TYPES_DIR) -outputdir $(CANONICAL_TYPES_BUILD_DIR) $(CANONICAL_TYPES_DIR)/InvalidMetatronFold.hs >/dev/null 2>$(CANONICAL_TYPES_BUILD_DIR)/invalid-metatron-fold.err; then \
			printf '%s\n' "FAIL: invalid Metatron fold witness compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(CANONICAL_TYPES_DIR) -outputdir $(CANONICAL_TYPES_BUILD_DIR) $(CANONICAL_TYPES_DIR)/InvalidAddressPlane.hs >/dev/null 2>$(CANONICAL_TYPES_BUILD_DIR)/invalid-address-plane.err; then \
			printf '%s\n' "FAIL: invalid address plane compiled unexpectedly"; exit 1; \
		fi; \
		printf '%s\n' "Canonical authority type-level rejection checks passed"; \
	else \
		printf '%s\n' "SKIP: ghc not available for canonical authority type-level checks"; \
	fi

test-meta-compiler-types: $(META_COMPILER_TYPES_MAIN) $(META_COMPILER_TYPES_CORE) | $(TEST_TMP_DIR)
	@if command -v ghc >/dev/null 2>&1; then \
		mkdir -p $(META_COMPILER_TYPES_BUILD_DIR); \
		ghc -fforce-recomp -i$(META_COMPILER_TYPES_DIR) -outputdir $(META_COMPILER_TYPES_BUILD_DIR) -o $(META_COMPILER_TYPES_BUILD_DIR)/meta-compiler-types $(META_COMPILER_TYPES_MAIN) >/dev/null || exit 1; \
		$(META_COMPILER_TYPES_BUILD_DIR)/meta-compiler-types; \
		if ghc -fforce-recomp -fno-code -i$(META_COMPILER_TYPES_DIR) -outputdir $(META_COMPILER_TYPES_BUILD_DIR) $(META_COMPILER_TYPES_DIR)/InvalidLocal240.hs >/dev/null 2>$(META_COMPILER_TYPES_BUILD_DIR)/invalid-local240.err; then \
			printf '%s\n' "FAIL: invalid local240 slot compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(META_COMPILER_TYPES_DIR) -outputdir $(META_COMPILER_TYPES_BUILD_DIR) $(META_COMPILER_TYPES_DIR)/InvalidSlot5040.hs >/dev/null 2>$(META_COMPILER_TYPES_BUILD_DIR)/invalid-slot5040.err; then \
			printf '%s\n' "FAIL: invalid slot5040 instruction compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(META_COMPILER_TYPES_DIR) -outputdir $(META_COMPILER_TYPES_BUILD_DIR) $(META_COMPILER_TYPES_DIR)/InvalidAssemblerToken.hs >/dev/null 2>$(META_COMPILER_TYPES_BUILD_DIR)/invalid-assembler-token.err; then \
			printf '%s\n' "FAIL: invalid assembler token compiled unexpectedly"; exit 1; \
		fi; \
		printf '%s\n' "Meta-compiler type-level rejection checks passed"; \
	else \
		printf '%s\n' "SKIP: ghc not available for meta-compiler type-level checks"; \
	fi

test-conformance-guardrail-types: $(CONFORMANCE_GUARDRAIL_TYPES_MAIN) $(CONFORMANCE_GUARDRAIL_TYPES_CORE) | $(TEST_TMP_DIR)
	@if command -v ghc >/dev/null 2>&1; then \
		mkdir -p $(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR); \
		ghc -fforce-recomp -i$(CONFORMANCE_GUARDRAIL_TYPES_DIR) -outputdir $(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR) -o $(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR)/conformance-guardrail-types $(CONFORMANCE_GUARDRAIL_TYPES_MAIN) >/dev/null || exit 1; \
		$(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR)/conformance-guardrail-types; \
		if ghc -fforce-recomp -fno-code -i$(CONFORMANCE_GUARDRAIL_TYPES_DIR) -outputdir $(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR) $(CONFORMANCE_GUARDRAIL_TYPES_DIR)/InvalidLocal240.hs >/dev/null 2>$(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR)/invalid-local240.err; then \
			printf '%s\n' "FAIL: invalid guardrail local240 compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(CONFORMANCE_GUARDRAIL_TYPES_DIR) -outputdir $(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR) $(CONFORMANCE_GUARDRAIL_TYPES_DIR)/InvalidFano.hs >/dev/null 2>$(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR)/invalid-fano.err; then \
			printf '%s\n' "FAIL: invalid guardrail fano selector compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(CONFORMANCE_GUARDRAIL_TYPES_DIR) -outputdir $(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR) $(CONFORMANCE_GUARDRAIL_TYPES_DIR)/InvalidMirror.hs >/dev/null 2>$(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR)/invalid-mirror.err; then \
			printf '%s\n' "FAIL: invalid guardrail mirror compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(CONFORMANCE_GUARDRAIL_TYPES_DIR) -outputdir $(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR) $(CONFORMANCE_GUARDRAIL_TYPES_DIR)/InvalidAssemblerToken.hs >/dev/null 2>$(CONFORMANCE_GUARDRAIL_TYPES_BUILD_DIR)/invalid-assembler-token.err; then \
			printf '%s\n' "FAIL: invalid guardrail assembler token compiled unexpectedly"; exit 1; \
		fi; \
		printf '%s\n' "Conformance guardrail type-level rejection checks passed"; \
	else \
		printf '%s\n' "SKIP: ghc not available for conformance guardrail type-level checks"; \
	fi

test-layer4-types: $(LAYER4_TYPES_MAIN) $(LAYER4_TYPES_CORE) | $(TEST_TMP_DIR)
	@if command -v ghc >/dev/null 2>&1; then \
		mkdir -p $(LAYER4_TYPES_BUILD_DIR); \
		ghc -fforce-recomp -i$(LAYER4_TYPES_DIR) -outputdir $(LAYER4_TYPES_BUILD_DIR) -o $(LAYER4_TYPES_BUILD_DIR)/layer4-types $(LAYER4_TYPES_MAIN) >/dev/null || exit 1; \
		$(LAYER4_TYPES_BUILD_DIR)/layer4-types; \
		if ghc -fforce-recomp -fno-code -i$(LAYER4_TYPES_DIR) -outputdir $(LAYER4_TYPES_BUILD_DIR) $(LAYER4_TYPES_DIR)/InvalidWeight.hs >/dev/null 2>$(LAYER4_TYPES_BUILD_DIR)/invalid-weight.err; then \
			printf '%s\n' "FAIL: invalid Layer-4 weight compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(LAYER4_TYPES_DIR) -outputdir $(LAYER4_TYPES_BUILD_DIR) $(LAYER4_TYPES_DIR)/InvalidNibble.hs >/dev/null 2>$(LAYER4_TYPES_BUILD_DIR)/invalid-nibble.err; then \
			printf '%s\n' "FAIL: invalid Layer-4 nibble compiled unexpectedly"; exit 1; \
		fi; \
		printf '%s\n' "Layer-4 Pascal type-level rejection checks passed"; \
	else \
		printf '%s\n' "SKIP: ghc not available for Layer-4 type-level checks"; \
	fi

test-metamorphic-types: $(METAMORPHIC_TYPES_MAIN) $(METAMORPHIC_TYPES_CORE) | $(TEST_TMP_DIR)
	@if command -v ghc >/dev/null 2>&1; then \
		mkdir -p $(METAMORPHIC_TYPES_BUILD_DIR); \
		ghc -fforce-recomp -i$(METAMORPHIC_TYPES_DIR) -outputdir $(METAMORPHIC_TYPES_BUILD_DIR) -o $(METAMORPHIC_TYPES_BUILD_DIR)/metamorphic-types $(METAMORPHIC_TYPES_MAIN) >/dev/null || exit 1; \
		$(METAMORPHIC_TYPES_BUILD_DIR)/metamorphic-types; \
		if ghc -fforce-recomp -fno-code -i$(METAMORPHIC_TYPES_DIR) -outputdir $(METAMORPHIC_TYPES_BUILD_DIR) $(METAMORPHIC_TYPES_DIR)/InvalidActiveIdentity.hs >/dev/null 2>$(METAMORPHIC_TYPES_BUILD_DIR)/invalid-active-identity.err; then \
			printf '%s\n' "FAIL: invalid active metamorphic identity compiled unexpectedly"; exit 1; \
		fi; \
		printf '%s\n' "Metamorphic export type-level rejection checks passed"; \
	else \
		printf '%s\n' "SKIP: ghc not available for metamorphic export type-level checks"; \
	fi

test-lagrange-types: $(LAGRANGE_TYPES_MAIN) $(LAGRANGE_TYPES_CORE) | $(TEST_TMP_DIR)
	@if command -v ghc >/dev/null 2>&1; then \
		mkdir -p $(LAGRANGE_TYPES_BUILD_DIR); \
		ghc -fforce-recomp -i$(LAGRANGE_TYPES_DIR) -outputdir $(LAGRANGE_TYPES_BUILD_DIR) -o $(LAGRANGE_TYPES_BUILD_DIR)/lagrange-types $(LAGRANGE_TYPES_MAIN) >/dev/null || exit 1; \
		$(LAGRANGE_TYPES_BUILD_DIR)/lagrange-types; \
		if ghc -fforce-recomp -fno-code -i$(LAGRANGE_TYPES_DIR) -outputdir $(LAGRANGE_TYPES_BUILD_DIR) $(LAGRANGE_TYPES_DIR)/InvalidByte.hs >/dev/null 2>$(LAGRANGE_TYPES_BUILD_DIR)/invalid-byte.err; then \
			printf '%s\n' "FAIL: invalid Lagrange byte compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(LAGRANGE_TYPES_DIR) -outputdir $(LAGRANGE_TYPES_BUILD_DIR) $(LAGRANGE_TYPES_DIR)/InvalidFoldBand.hs >/dev/null 2>$(LAGRANGE_TYPES_BUILD_DIR)/invalid-fold-band.err; then \
			printf '%s\n' "FAIL: invalid Lagrange fold band compiled unexpectedly"; exit 1; \
		fi; \
		if ghc -fforce-recomp -fno-code -i$(LAGRANGE_TYPES_DIR) -outputdir $(LAGRANGE_TYPES_BUILD_DIR) $(LAGRANGE_TYPES_DIR)/InvalidFoldSlot.hs >/dev/null 2>$(LAGRANGE_TYPES_BUILD_DIR)/invalid-fold-slot.err; then \
			printf '%s\n' "FAIL: invalid Lagrange fold slot compiled unexpectedly"; exit 1; \
		fi; \
		printf '%s\n' "Lagrange space type-level rejection checks passed"; \
	else \
		printf '%s\n' "SKIP: ghc not available for Lagrange space type-level checks"; \
	fi

$(ESP32_TEST): tests/esp32/esp32_omi_core_test.c $(ESP32_EXAMPLE) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/esp32/esp32_omi_core_test.c -o $@

test-esp32: $(ESP32_TEST)
	$(ESP32_TEST)

$(ESP32_GOSSIP_TEST): tests/esp32/esp32_p2p_gossip_test.c $(ESP32_GOSSIP_EXAMPLE) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/esp32/esp32_p2p_gossip_test.c -o $@

test-esp32-gossip: $(ESP32_GOSSIP_TEST)
	$(ESP32_GOSSIP_TEST)

$(BOOT_ENVELOPE_TEST): tests/esp32/omi_boot_envelope_test.c $(BOOT_ENVELOPE_EXAMPLE) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/esp32/omi_boot_envelope_test.c -o $@

test-boot-envelope: $(BOOT_ENVELOPE_TEST)
	$(BOOT_ENVELOPE_TEST)

$(OMNICRON_EPISTEMIC_TEST): tests/esp32/omnicron_epistemic_core_test.c $(OMNICRON_EPISTEMIC_EXAMPLE) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/esp32/omnicron_epistemic_core_test.c -o $@

test-omnicron-epistemic: $(OMNICRON_EPISTEMIC_TEST)
	$(OMNICRON_EPISTEMIC_TEST)

test-tcg-backend-spec: $(TCG_TARGET_HEADER) $(TCG_TARGET_IMPL)
	@grep -q 'TCG_TARGET_REG_BITS 64' $(TCG_TARGET_HEADER)
	@grep -q 'TCG_TARGET_NB_REGS 16' $(TCG_TARGET_HEADER)
	@grep -q 'TCG_TARGET_HAS_div_i64 0' $(TCG_TARGET_HEADER)
	@grep -q 'TCG_REG_TMP = TCG_REG_R15' $(TCG_TARGET_HEADER)
	@grep -q 'C_NotImplemented' $(TCG_TARGET_IMPL)
	@grep -q 'tcg_abort' $(TCG_TARGET_IMPL)
	@printf '%s\n' "TCG backend specification verified: examples/tcg"

$(RUNTIME_LOCK_TEST): tests/runtime-lock/runtime_lock_conformance.c $(SRC) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/runtime-lock/runtime_lock_conformance.c $(LDFLAGS) -o $@

test-runtime-lock: $(RUNTIME_LOCK_TEST)
	$(RUNTIME_LOCK_TEST)

$(MEDIA_BRIDGE_TEST): tests/media/omi_media_bridge_test.c $(MEDIA_BRIDGE_EXAMPLE) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/media/omi_media_bridge_test.c -o $@

test-media-bridge: $(MEDIA_BRIDGE_TEST)
	$(MEDIA_BRIDGE_TEST)

$(METATRON_PRECLOSURE_TEST): tests/metatron/metatron_preclosure_test.c $(METATRON_PRECLOSURE_EXAMPLE) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/metatron/metatron_preclosure_test.c -o $@

test-metatron-preclosure: $(METATRON_PRECLOSURE_TEST)
	$(METATRON_PRECLOSURE_TEST)

$(BASE_METRIC_TEST): tests/radix/base_metric_seed_model_test.c $(BASE_METRIC_EXAMPLE) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/radix/base_metric_seed_model_test.c -o $@

test-base-metric: $(BASE_METRIC_TEST)
	$(BASE_METRIC_TEST)

$(BINARY_EXPORT_TEST): tests/compiler/binary_export_verifier_test.c $(BINARY_EXPORT_EXAMPLE) | $(TEST_TMP_DIR)
	$(CC) $(CFLAGS) tests/compiler/binary_export_verifier_test.c -o $@

test-binary-export: $(BINARY_EXPORT_TEST)
	$(BINARY_EXPORT_TEST)

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

octahedral-router-test: $(OCTAHEDRAL_ROUTER) $(OCTAHEDRAL_ROUTER_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(OCTAHEDRAL_ROUTER_OUT) $(OCTAHEDRAL_ROUTER) $(OCTAHEDRAL_ROUTER_TB); \
		vvp $(OCTAHEDRAL_ROUTER_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional octahedral router backend"; \
	fi

metatron-scribe-test: $(METATRON_SCRIBE) $(METATRON_SCRIBE_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(METATRON_SCRIBE_OUT) $(METATRON_SCRIBE) $(METATRON_SCRIBE_TB); \
		vvp $(METATRON_SCRIBE_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional Metatron scribe backend"; \
	fi

omnicron-bqf-test: $(OMNICRON_BQF_RESOLVER) $(OMNICRON_BQF_RESOLVER_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(OMNICRON_BQF_RESOLVER_OUT) $(OMNICRON_BQF_RESOLVER) $(OMNICRON_BQF_RESOLVER_TB); \
		vvp $(OMNICRON_BQF_RESOLVER_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional Omnicron BQF backend"; \
	fi

fano-slot-test: $(FANO_SLOT_SCHEDULER) $(FANO_SLOT_SCHEDULER_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(FANO_SLOT_SCHEDULER_OUT) $(FANO_SLOT_SCHEDULER) $(FANO_SLOT_SCHEDULER_TB); \
		vvp $(FANO_SLOT_SCHEDULER_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional Fano slot scheduler backend"; \
	fi

meta-assembler-test: $(META_ASSEMBLER) $(META_ASSEMBLER_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(META_ASSEMBLER_OUT) $(META_ASSEMBLER) $(META_ASSEMBLER_TB); \
		vvp $(META_ASSEMBLER_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional EAL meta-assembler backend"; \
	fi

backplane-monitor-test: $(BACKPLANE_MONITOR) $(BACKPLANE_MONITOR_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(BACKPLANE_MONITOR_OUT) $(BACKPLANE_MONITOR) $(BACKPLANE_MONITOR_TB); \
		vvp $(BACKPLANE_MONITOR_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional backplane monitor backend"; \
	fi

layer4-multiplicity-test: $(LAYER4_MULTIPLICITY) $(LAYER4_MULTIPLICITY_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(LAYER4_MULTIPLICITY_OUT) $(LAYER4_MULTIPLICITY) $(LAYER4_MULTIPLICITY_TB); \
		vvp $(LAYER4_MULTIPLICITY_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional Layer-4 multiplicity backend"; \
	fi

metamorphic-export-test: $(METAMORPHIC_EXPORT_VALIDATOR) $(METAMORPHIC_EXPORT_VALIDATOR_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(METAMORPHIC_EXPORT_VALIDATOR_OUT) $(METAMORPHIC_EXPORT_VALIDATOR) $(METAMORPHIC_EXPORT_VALIDATOR_TB); \
		vvp $(METAMORPHIC_EXPORT_VALIDATOR_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional metamorphic export backend"; \
	fi

visual-matrix-test: $(VISUAL_MATRIX_PROJECTOR) $(VISUAL_MATRIX_PROJECTOR_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(VISUAL_MATRIX_PROJECTOR_OUT) $(VISUAL_MATRIX_PROJECTOR) $(VISUAL_MATRIX_PROJECTOR_TB); \
		vvp $(VISUAL_MATRIX_PROJECTOR_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional visual matrix backend"; \
	fi

lagrange-space-test: $(LAGRANGE_SPACE_RESOLVER) $(LAGRANGE_SPACE_RESOLVER_TB) | $(TEST_TMP_DIR)
	@if command -v iverilog >/dev/null 2>&1 && command -v vvp >/dev/null 2>&1; then \
		iverilog -g2012 -Wall -o $(LAGRANGE_SPACE_RESOLVER_OUT) $(LAGRANGE_SPACE_RESOLVER) $(LAGRANGE_SPACE_RESOLVER_TB); \
		vvp $(LAGRANGE_SPACE_RESOLVER_OUT); \
	else \
		printf '%s\n' "SKIP: iverilog/vvp not available for optional Lagrange space backend"; \
	fi

clock-crosscheck: $(LAMBDA_CORE_VECTORS) $(OCTAHEDRAL_ROUTER_VECTORS) $(METATRON_SCRIBE_VECTORS) $(OMNICRON_BQF_RESOLVER_VECTORS) $(FANO_SLOT_SCHEDULER_VECTORS) $(META_ASSEMBLER_VECTORS) $(BACKPLANE_MONITOR_VECTORS) $(LAYER4_MULTIPLICITY_VECTORS) $(METAMORPHIC_EXPORT_VECTORS) $(VISUAL_MATRIX_VECTORS) $(LAGRANGE_SPACE_VECTORS) verilog-test octahedral-router-test metatron-scribe-test omnicron-bqf-test fano-slot-test meta-assembler-test backplane-monitor-test layer4-multiplicity-test metamorphic-export-test visual-matrix-test lagrange-space-test
	@if command -v jq >/dev/null 2>&1; then \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and .x_omi and .y_imo and .character_token and has("received_omnion") and .parabolic_eval and has("is_void_centroid") and has("observer_boundary") and has("is_admissible")' >/dev/null || exit 1; done < $(LAMBDA_CORE_VECTORS); \
		printf '%s\n' "Lambda Canon core vectors verified: $(LAMBDA_CORE_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and .cons_address and has("active_face") and has("interface_6_4") and has("interface_8_3") and has("centroid_lock")' >/dev/null || exit 1; done < $(OCTAHEDRAL_ROUTER_VECTORS); \
		printf '%s\n' "Octahedral face router vectors verified: $(OCTAHEDRAL_ROUTER_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and has("step_cmd") and .sector_prefix and .gauge_polarity and .gauge_register and .incidence_witness and .plane_flags and has("gauge_carry")' >/dev/null || exit 1; done < $(METATRON_SCRIBE_VECTORS); \
		printf '%s\n' "Metatron incidence scribe vectors verified: $(METATRON_SCRIBE_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and has("x_field") and has("y_unit") and .stream_byte and has("address_energy") and has("byte_band") and has("delineation_active") and has("null_boundary_trap")' >/dev/null || exit 1; done < $(OMNICRON_BQF_RESOLVER_VECTORS); \
		printf '%s\n' "Omnicron BQF resolver vectors verified: $(OMNICRON_BQF_RESOLVER_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and has("fano7") and has("role3") and has("local240") and has("slot5040") and has("bounds_fault")' >/dev/null || exit 1; done < $(FANO_SLOT_SCHEDULER_VECTORS); \
		printf '%s\n' "Fano slot scheduler vectors verified: $(FANO_SLOT_SCHEDULER_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and .core_opcode and has("slot5040") and .character_token and .machine_instruction and has("is_centroid_core") and has("assembler_ready")' >/dev/null || exit 1; done < $(META_ASSEMBLER_VECTORS); \
		printf '%s\n' "EAL meta-assembler vectors verified: $(META_ASSEMBLER_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and .local_azimuth and .remote_azimuth and has("tetra_sum") and has("hamming_double_err") and has("lockout_n") and has("diagnose_fault_id")' >/dev/null || exit 1; done < $(BACKPLANE_MONITOR_VECTORS); \
		printf '%s\n' "Backplane interlock monitor vectors verified: $(BACKPLANE_MONITOR_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and .local_nibble and has("tetra_weight") and has("compact_branch") and has("extended_branch")' >/dev/null || exit 1; done < $(LAYER4_MULTIPLICITY_VECTORS); \
		printf '%s\n' "Layer-4 multiplicity vectors verified: $(LAYER4_MULTIPLICITY_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and .eal_byte and has("eal_valid") and .void_byte and has("void_valid") and has("export_identity_ok") and has("bus_interlock_lock")' >/dev/null || exit 1; done < $(METAMORPHIC_EXPORT_VECTORS); \
		printf '%s\n' "Metamorphic export vectors verified: $(METAMORPHIC_EXPORT_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and .local_nibble and has("matrix_row_x") and has("matrix_col_y") and has("view_is_inert")' >/dev/null || exit 1; done < $(VISUAL_MATRIX_VECTORS); \
		printf '%s\n' "Visual matrix vectors verified: $(VISUAL_MATRIX_VECTORS)"; \
		while IFS= read -r line; do printf '%s\n' "$$line" | jq -e '.name and .stream_byte and has("manual_slot") and has("manual_band") and has("trigger_fold") and has("unfolded_band") and has("unfolded_slot") and .folded_byte and has("canvas_x") and has("canvas_y") and has("byte_bounds_fault")' >/dev/null || exit 1; done < $(LAGRANGE_SPACE_VECTORS); \
		printf '%s\n' "Lagrange space vectors verified: $(LAGRANGE_SPACE_VECTORS)"; \
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
