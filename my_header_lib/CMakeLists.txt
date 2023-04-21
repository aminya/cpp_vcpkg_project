add_library(my_header_lib INTERFACE)
# link project_options/warnings
target_link_libraries(my_header_lib INTERFACE my_project_options my_project_warnings)

# Includes
target_include_interface_directories(my_header_lib include)

# Find dependencies:
target_find_dependencies(my_header_lib INTERFACE_CONFIG fmt)

# Link dependencies:
target_link_system_libraries(my_header_lib INTERFACE fmt::fmt)

if(FEATURE_TESTS)
  add_subdirectory("./test")
endif()
