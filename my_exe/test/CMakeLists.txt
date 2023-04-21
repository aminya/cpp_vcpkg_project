# test dependencies
include(CTest)

# ----------------------------------------------------------------------------------------------------------------------
# test the executable part
add_test(
  # calling my_exe executable directly
  NAME my_exe_test
  COMMAND my_exe ""
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

# ----------------------------------------------------------------------------------------------------------------------
# test the library part
add_executable(my_exe_lib_tests "./tests.cpp")
target_link_libraries(
  my_exe_lib_tests
  PRIVATE my_project_warnings
          my_project_options
          catch2_test_common
          my_exe_lib)

# use xml reporter if coverage is enabled
if(${ENABLE_COVERAGE})
  set(COVERAGE_ARGS REPORTER xml)
endif()

# automatically discover tests that are defined in catch based test files you can modify the tests
catch_discover_tests(my_exe_lib_tests ${COVERAGE_ARGS})
