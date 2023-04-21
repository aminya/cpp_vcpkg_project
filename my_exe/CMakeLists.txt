# Separate library part and executable part (`main()` function) to simplify testing.

# ----------------------------------------------------------------------------------------------------------------------
# library part
add_library(my_exe_lib INTERFACE) # use interface or normal library according to the implementation
# link project_options/warnings
target_link_libraries(my_exe_lib INTERFACE my_project_options my_project_warnings)

# Includes
target_include_interface_directories(my_exe_lib include)

# Find dependencies:
target_find_dependencies(my_exe_lib INTERFACE_CONFIG fmt)

# Link dependencies:
target_link_system_libraries(my_exe_lib INTERFACE fmt::fmt)

# ----------------------------------------------------------------------------------------------------------------------
# executable part
add_executable(my_exe "./src/main.cpp") # just for `main.cpp` which contains `main()` function
# link project_options/warnings
target_link_libraries(my_exe PRIVATE my_project_options my_project_warnings)

# Includes, just link the library part
target_link_libraries(my_exe PRIVATE my_exe_lib)

# Find dependencies:
target_find_dependencies(my_exe PRIVATE_CONFIG fmt)

# Link dependencies
target_link_system_libraries(my_exe PRIVATE fmt::fmt)

# ----------------------------------------------------------------------------------------------------------------------
# tests
if(FEATURE_TESTS)
  add_subdirectory("./test")
endif()
