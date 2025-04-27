#! Prefer using task with Taskfile.yml, which is a cross-platform replacement for Makefile with better error-handling and syntax.

# Notes:
# - list all the task under PHONY
# - If getting missing separator error, try replacing spaces with tabs.
# - If using Visual Studio, either run the following commands inside the Visual Studio command prompt (vcvarsall)
#   or remove the Ninja generator from the commands.
# Standard stuff

.SUFFIXES:

MAKEFLAGS+= --no-builtin-rules
MAKEFLAGS+= --warn-undefined-variables

OS?=$(shell uname)
export PROJECT_DIR?=$(shell basename $(CURDIR))
export BUILD_DIR?=$(CURDIR)/build

.PHONY: all build test test_release test_install test_release_debug coverage docs format clean distclean

build: release

all: test_release test_install test_release_debug coverage doc

release:
	cmake --workflow --preset Release

debug: test
test:
	cmake --workflow --preset developer

test_release_debug:
	cmake --workflow --preset RelWithDebInfo

test_release:
	cmake --workflow --preset gcc-release

test_install:
	cmake --workflow --preset clang-release

coverage:
ifeq ($(OS), Windows_NT)
	OpenCppCoverage.exe --export_type cobertura:coverage.xml --cover_children -- $(MAKE) test
else
	$(MAKE) test
	gcovr -j 1 --delete --root $(CURDIR) --print-summary --xml-pretty --xml coverage.xml $(BUILD_DIR)/developer --gcov-executable gcov
endif

docs:
	cmake --build $(BUILD_DIR)/developer --target doxygen-docs --config Coverage

format:
ifeq ($(OS), Windows_NT)
	pwsh -c '$$files=(git ls-files --exclude-standard); foreach ($$file in $$files) { if ((get-item $$file).Extension -in ".json", ".cpp", ".hpp", ".c", ".cc", ".cxx", ".hxx", ".ixx") { clang-format -i -style=file $$file } }'
else
	git ls-files --exclude-standard | grep -E '\.(json|cpp|hpp|c|cc|cxx|hxx|ixx)$$' | xargs clang-format -i -style=file
endif

clean:
ifeq ($(OS), Windows_NT)
	pwsh -c 'function rmrf($$path) { if (test-path $$path) { rm -r -force $$path }}; rmrf $(BUILD_DIR);'
else
	rm -rf $(BUILD_DIR)
endif

distclean: clean
ifeq ($(OS), Windows_NT)
	pwsh -c 'function rmrf($$path) { if (test-path $$path) { rm -r -force $$path }}; rmrf ./install;'
else
	rm -rf ./install
endif

# Anything we don't know how to build will use this rule.
# The command is a do-nothing command.
#
% :: ;
