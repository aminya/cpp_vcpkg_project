# Add a file containing a set of constexpr tests
add_library_test(my_lib constexpr_tests CONFIGS common SOURCES constexpr_tests.cpp)

# Disable the constexpr portion of the test, and build again this allows us to have an executable that we can debug when
# things go wrong with the constexpr testing
add_library_test(my_lib relaxed_constexpr_tests
  CONFIGS
  common

  SOURCES
  constexpr_tests.cpp

  COMPILE_DEFINITIONS
  -DCATCH_CONFIG_RUNTIME_STATIC_REQUIRE
)

# Or for reuse:
#
# add_test_config(relaxed_constexpr
#   COMPILE_DEFINITIONS
#   -DCATCH_CONFIG_RUNTIME_STATIC_REQUIRE
# )
#
# add_library_test(my_lib relaxed_constexpr_tests CONFIGS common relaxed_constexpr SOURCES constexpr_tests.cpp)