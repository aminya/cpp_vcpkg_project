# test dependencies
set(tests_DEPENDENCIES_CONFIGURED Catch2)

foreach(DEPENDENCY ${tests_DEPENDENCIES_CONFIGURED})
  find_package(${DEPENDENCY} CONFIG REQUIRED)
endforeach()

include(CTest)
include(Catch)

# calling my_exe executable directly
add_test(
  NAME my_exe_test
  COMMAND my_exe ""
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

# testing helpers
add_executable(my_exe_helpers_tests "./tests.cpp")

# because my_exe helpers and dependencies are private, we should link them here again
target_include_directories(my_exe_helpers_tests PRIVATE "${my_exe_INCLUDE_DIR}")

target_link_libraries(
  my_exe_helpers_tests
  PRIVATE project_warnings
          project_options
          Catch2::Catch2
          ${my_exe_LINKED_LIBRARIES})

# generate a main function for the test executable
target_compile_definitions(my_exe_helpers_tests PRIVATE CATCH_CONFIG_MAIN)

# use xml reporter if coverage is enabled
if(${ENABLE_COVERAGE})
  set(COVERAGE_ARGS REPORTER xml)
endif()
