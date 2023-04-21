# Add a file containing a set of constexpr tests
add_executable(my_header_lib_constexpr_tests "./constexpr_tests.cpp")

target_link_libraries(
  my_header_lib_constexpr_tests
  PRIVATE my_header_lib
          my_project_warnings
          my_project_options
          catch2_test_common)

catch_discover_tests(my_header_lib_constexpr_tests ${COVERAGE_ARGS})

# Disable the constexpr portion of the test, and build again this allows us to have an executable that we can debug when
# things go wrong with the constexpr testing
add_executable(my_header_lib_relaxed_constexpr_tests "./constexpr_tests.cpp")

target_link_libraries(
  my_header_lib_relaxed_constexpr_tests
  PRIVATE my_header_lib
          my_project_warnings
          my_project_options
          catch2_test_common)
target_compile_definitions(my_header_lib_relaxed_constexpr_tests
                           PRIVATE -DCATCH_CONFIG_RUNTIME_STATIC_REQUIRE)

catch_discover_tests(my_header_lib_relaxed_constexpr_tests ${COVERAGE_ARGS})
