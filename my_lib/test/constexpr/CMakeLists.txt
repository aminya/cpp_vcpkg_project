# Add a file containing a set of constexpr tests
add_executable(my_lib_constexpr_tests "./constexpr_tests.cpp")

target_link_libraries(
  my_lib_constexpr_tests
  PRIVATE my_lib
          project_warnings
          project_options
          Catch2::Catch2)
target_compile_definitions(my_lib_constexpr_tests PRIVATE CATCH_CONFIG_MAIN DO_NOT_USE_WMAIN)

catch_discover_tests(my_lib_constexpr_tests ${COVERAGE_ARGS})

# Disable the constexpr portion of the test, and build again this allows us to have an executable that we can debug when
# things go wrong with the constexpr testing
add_executable(my_lib_relaxed_constexpr_tests "./constexpr_tests.cpp")

target_link_libraries(
  my_lib_relaxed_constexpr_tests
  PRIVATE my_lib
          project_warnings
          project_options
          Catch2::Catch2)
target_compile_definitions(my_lib_relaxed_constexpr_tests PRIVATE CATCH_CONFIG_MAIN DO_NOT_USE_WMAIN)
target_compile_definitions(my_lib_relaxed_constexpr_tests PRIVATE -DCATCH_CONFIG_RUNTIME_STATIC_REQUIRE)

catch_discover_tests(my_lib_relaxed_constexpr_tests ${COVERAGE_ARGS})
