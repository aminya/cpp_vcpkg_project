add_executable(my_exe main.cpp)
target_link_libraries(my_exe PRIVATE project_options project_warnings) # link project_options/warnings

# Find dependencies:
set(DEPENDENCIES_CONFIGURED fmt)

foreach(DEPENDENCY ${DEPENDENCIES_CONFIGURED})
  find_package(${DEPENDENCY} CONFIG REQUIRED)
endforeach()

# Link dependencies
target_link_system_libraries(my_exe PRIVATE fmt::fmt)

# Package the project
package_project(TARGETS my_exe)
