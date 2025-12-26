#===============================================================
#   Makefile for clib (static library) + test programs         #
#                                                              #
#   This Makefile is "quiet" by default: it prints friendly    #
#   status messages instead of raw compiler commands.          #
#                                                              #
#   Targets:                                                   #
#     make           -> build library + tests									 #
#     make lib       -> build libclib.a into build/lib/        #
#     make tests     -> build tests into build/bin/            #
#     make run-tests -> run the built test binaries            #
#     make clean     -> remove build output                    #
#     make help      -> show this help message                 #
#																														   #
#   Verbose mode:											                         #
#     make V=1       -> show full commands (gcc/ar/etc.)       #
#																						                   #								
#   Override variables if desired:														 #
#     make CC=clang CSTD=c11															     #
#===============================================================

MAKEFLAGS += --no-print-directory

# Default target when running plain `make`
.DEFAULT_GOAL := all


CC       ?= gcc
AR       ?= ar
CSTD     ?= c99
CFLAGS   ?= -O2 -std=$(CSTD) -Wall -Wextra -pedantic
CPPFLAGS ?= -Iinclude
LDLIBS   ?= -lm

BUILD    := build
OBJDIR   := $(BUILD)/obj
BINDIR   := $(BUILD)/bin
LIBDIR   := $(BUILD)/lib

LIBNAME  := clib
LIB      := $(LIBDIR)/lib$(LIBNAME).a

SRC      := $(wildcard src/*.c)
OBJ      := $(patsubst src/%.c,$(OBJDIR)/%.o,$(SRC))

TESTSRC  := $(wildcard tests/*.c)
TESTBIN  := $(patsubst tests/%.c,$(BINDIR)/%,$(TESTSRC))

#--------------------------------------------------------------#
#    Quiet vs verbose output                                   #
#--------------------------------------------------------------#

ifeq ($(V),1)
  Q :=
else
  Q := @
endif

.PHONY: all lib tests run-tests clean help

help:
	@echo "Targets:"
	@echo "  make / make all     Build library + tests"
	@echo "  make lib            Build $(LIB)"
	@echo "  make tests          Build test binaries into $(BINDIR)/"
	@echo "  make run-tests      Run all test binaries"
	@echo "  make clean          Remove $(BUILD)/"
	@echo ""
	@echo "Options:"
	@echo "  V=1                 Verbose build (show commands)"
	@echo "  CC=... CSTD=...     Override toolchain / C standard"

all: lib tests

#--------------------------------------------------------------#
#    Static library build rules                                #
#--------------------------------------------------------------#

lib: $(LIB)

$(LIB): $(OBJ) | $(LIBDIR)
	@echo "Archiving static library: $@"
	$(Q)$(AR) rcs $@ $^

$(OBJDIR)/%.o: src/%.c | $(OBJDIR)
	@echo "Compiling: $<"
	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(OBJDIR):
	@echo "Creating directory: $(OBJDIR)"
	$(Q)mkdir -p $(OBJDIR)

$(LIBDIR):
	@echo "Creating directory: $(LIBDIR)"
	$(Q)mkdir -p $(LIBDIR)

#--------------------------------------------------------------#
#    Tests (compile executables, do not run by default)        #
#--------------------------------------------------------------#

tests: $(TESTBIN)
	@echo "Built $(words $(TESTBIN)) test binaries in $(BINDIR)/"

$(BINDIR)/%: tests/%.c $(LIB) | $(BINDIR)
	@echo "Linking test binary: $@"
	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) $< $(LIB) $(LDLIBS) -o $@

$(BINDIR):
	@echo "Creating directory: $(BINDIR)"
	$(Q)mkdir -p $(BINDIR)

run-tests: tests
	@echo "Running test binaries..."
	@for t in $(TESTBIN); do \
		echo "== $$t =="; \
		"$$t"; \
	done

#--------------------------------------------------------------#
#    Cleanup rules                                             #
#--------------------------------------------------------------#

clean:
	@echo "Cleaning up..."
	$(Q)rm -rf $(BUILD)
