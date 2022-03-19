add_executable(exe main.cpp)
target_link_libraries(exe PRIVATE project_options project_warnings) # link project_options/warnings

# Find dependencies:
set(DEPENDENCIES_CONFIGURED fmt tl-expected)

foreach(DEPENDENCY ${DEPENDENCIES_CONFIGURED})
  find_package(${DEPENDENCY} CONFIG REQUIRED)
endforeach()

# Link dependencies
target_link_system_libraries(
  exe
  PRIVATE
  fmt::fmt
  tl::expected)

# Package the project
package_project(TARGETS exe)
