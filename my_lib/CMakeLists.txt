add_library(my_lib "./src/my_lib/lib.cpp")
# link project_options/warnings
target_link_libraries(my_lib PRIVATE my_project_options my_project_warnings)

# Includes
target_include_interface_directories(my_lib include)

# Find dependencies:
target_find_dependencies(my_lib PRIVATE_CONFIG fmt)

# Link dependencies:
target_link_system_libraries(my_lib PRIVATE fmt::fmt)

if(FEATURE_TESTS)
  add_subdirectory("./test")
endif()
