add_library(my_header_lib INTERFACE)
target_link_libraries(my_header_lib INTERFACE project_options project_warnings) # link project_options/warnings

# Includes
set(INCLUDE_DIR "include") # must be relative paths
target_include_directories(my_header_lib INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${INCLUDE_DIR}>"
                                                "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")

# Find dependencies:
set(DEPENDENCIES_CONFIGURED fmt)

foreach(DEPENDENCY ${DEPENDENCIES_CONFIGURED})
  find_package(${DEPENDENCY} CONFIG REQUIRED)
endforeach()

# Link dependencies:
target_link_system_libraries(my_header_lib INTERFACE fmt::fmt)

# Package the project
package_project(
  TARGETS
  my_header_lib
  project_options
  project_warnings
  INTERFACE_DEPENDENCIES_CONFIGURED
  ${DEPENDENCIES_CONFIGURED}
  INTERFACE_INCLUDES
  ${INCLUDE_DIR})
