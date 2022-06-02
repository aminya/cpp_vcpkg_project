# test dependencies
set(tests_DEPENDENCIES_CONFIGURED Catch2)

foreach(DEPENDENCY ${tests_DEPENDENCIES_CONFIGURED})
  find_package(${DEPENDENCY} CONFIG REQUIRED)
endforeach()

include(CTest)
include(Catch)

# test executable

add_executable(my_lib_tests "./tests.cpp")

target_link_libraries(
  my_lib_tests
  PRIVATE my_lib
          project_warnings
          project_options
          Catch2::Catch2)
# generate a main function for the test executable
target_compile_definitions(my_lib_tests PRIVATE CATCH_CONFIG_MAIN DO_NOT_USE_WMAIN)

# use xml reporter if coverage is enabled
if(${ENABLE_COVERAGE})
  set(COVERAGE_ARGS REPORTER xml)
endif()

# automatically discover tests that are defined in catch based test files you can modify the tests
catch_discover_tests(my_lib_tests ${COVERAGE_ARGS})

# constexpr tests
add_subdirectory("./constexpr")
