add_library(my_lib "./src/my_lib/lib.cpp")
target_link_libraries(my_lib PRIVATE project_options project_warnings) # link project_options/warnings

# Includes
set(INCLUDE_DIR "include") # must be relative paths
target_include_directories(my_lib PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${INCLUDE_DIR}>"
                                         "$<INSTALL_INTERFACE:./${CMAKE_INSTALL_INCLUDEDIR}>")

# Find dependencies:
set(DEPENDENCIES_CONFIGURED fmt)

foreach(DEPENDENCY ${DEPENDENCIES_CONFIGURED})
  find_package(${DEPENDENCY} CONFIG REQUIRED)
endforeach()

# Link dependencies:
target_link_system_libraries(my_lib PRIVATE fmt::fmt)

# Package the project
package_project(
  TARGETS
  my_lib
  PUBLIC_INCLUDES
  ${INCLUDE_DIR})
