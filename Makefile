SHELL := /bin/bash -x
BUILDDIR := build
TEXMFCACHE := $(CURDIR)/$(BUILDDIR)/texmf-cache

EXAMPLES := $(basename $(notdir $(wildcard examples/*.tex)))

# luaotfload derives its writable TEXMFCACHE from TEXMFVAR on TeX Live.
LATEXMK := OSFONTDIR=$(CURDIR)/examples TEXMFHOME=$(CURDIR)/texmf TEXMFVAR=$(TEXMFCACHE) TEXINPUTS=$(CURDIR)/tex//: latexmk -cd
LUA_SOURCES := $(wildcard tex/*.lua)
TEX_SOURCES := $(sort $(shell find examples tex -type f \( -name '*.tex' -o -name '*.sty' -o -name '*.cls' \)))

.PHONY: all examples clean check fmt lint

all: examples

examples: $(addprefix example-,$(EXAMPLES))

example-%: | $(TEXMFCACHE)
	$(LATEXMK) -outdir=$(abspath $(BUILDDIR)/examples) -jobname=$* examples/$*.tex

example-%-pv: | $(TEXMFCACHE)
	$(LATEXMK) -pv -outdir=$(abspath $(BUILDDIR)/examples) -jobname=$* examples/$*.tex

example-%-pvc: | $(TEXMFCACHE)
	$(LATEXMK) -pvc -outdir=$(abspath $(BUILDDIR)/examples) -jobname=$* examples/$*.tex

$(TEXMFCACHE):
	mkdir -p $@
	OSFONTDIR=$(CURDIR)/examples TEXMFVAR=$(TEXMFCACHE) luaotfload-tool --update

clean:
	rm -rf $(BUILDDIR)

check: lint all

lint:
	mbake validate Makefile
	mbake format --check Makefile
	tex-fmt --check $(TEX_SOURCES)
	stylua --check $(LUA_SOURCES)

fmt:
	mbake format Makefile
	tex-fmt $(TEX_SOURCES)
	stylua $(LUA_SOURCES)