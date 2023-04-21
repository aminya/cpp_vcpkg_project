# building the tests
option(FEATURE_TESTS "Enable the tests" OFF)
if(FEATURE_TESTS)
  list(APPEND VCPKG_MANIFEST_FEATURES "tests")
endif()

# building the docs
option(FEATURE_DOCS "Enable the docs" OFF)

# fuzz tests
option(FEATURE_FUZZ_TESTS "Enable the fuzz tests" OFF)

option(ENABLE_CROSS_COMPILING "Detect cross compiler and setup toolchain" OFF)
