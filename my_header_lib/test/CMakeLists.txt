# test dependencies
include(CTest)

# test executable
add_executable(my_header_lib_tests "./tests.cpp")

target_link_libraries(
  my_header_lib_tests
  PRIVATE my_header_lib
          my_project_warnings
          my_project_options
          catch2_test_common)

# use xml reporter if coverage is enabled
if(${ENABLE_COVERAGE})
  set(COVERAGE_ARGS REPORTER xml)
endif()

# automatically discover tests that are defined in catch based test files you can modify the tests
catch_discover_tests(my_header_lib_tests ${COVERAGE_ARGS})

# constexpr tests
add_subdirectory("./constexpr")
