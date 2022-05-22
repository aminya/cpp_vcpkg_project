# A fuzz test runs until it finds an error. This particular one is going to rely on libFuzzer.
#
message("Building Fuzz Tests, using fuzzing sanitizer https://www.llvm.org/docs/LibFuzzer.html")

add_executable(my_header_lib_fuzz_main "./fuzz_tester.cpp")
target_link_libraries(
  my_header_lib_fuzz_main
  PRIVATE my_header_lib
          project_options
          project_warnings
          -coverage
          -fsanitize=fuzzer,undefined,address)
target_compile_options(my_header_lib_fuzz_main PRIVATE -fsanitize=fuzzer,undefined,address)

# Allow short runs during automated testing to see if something new breaks
set(FUZZ_RUNTIME
    10
    CACHE STRING "Number of seconds to run fuzz tests during ctest run") # Default of 10 seconds

add_test(NAME my_header_lib_fuzz_tests COMMAND my_header_lib_fuzz_main -max_total_time=${FUZZ_RUNTIME})
