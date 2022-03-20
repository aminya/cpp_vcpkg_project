# Add a file containing a set of constexpr tests
add_executable(my_exe_constexpr_tests "./constexpr_tests.cpp")

target_link_libraries(my_exe_constexpr_tests PRIVATE project_warnings project_options Catch2::Catch2)
target_compile_definitions(my_exe_constexpr_tests PRIVATE CATCH_CONFIG_MAIN)

catch_discover_tests(my_exe_constexpr_tests ${COVERAGE_ARGS})

# Disable the constexpr portion of the test, and build again this allows us to have an executable that we can debug when
# things go wrong with the constexpr testing
add_executable(my_exe_relaxed_constexpr_tests "./constexpr_tests.cpp")

target_link_libraries(my_exe_relaxed_constexpr_tests PRIVATE project_warnings project_options Catch2::Catch2)
target_compile_definitions(my_exe_relaxed_constexpr_tests PRIVATE CATCH_CONFIG_MAIN)
target_compile_definitions(my_exe_relaxed_constexpr_tests PRIVATE -DCATCH_CONFIG_RUNTIME_STATIC_REQUIRE)

catch_discover_tests(my_exe_relaxed_constexpr_tests ${COVERAGE_ARGS})
