add_library(my_lib "./src/my_lib/lib.cpp")
# link project_options/warnings
target_link_libraries(my_lib PRIVATE my_project_options my_project_warnings)

# Includes
set(my_lib_INCLUDE_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
    CACHE STRING "")
target_include_directories(my_lib PUBLIC "$<BUILD_INTERFACE:${my_lib_INCLUDE_DIR}>"
                                         "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")
# Find dependencies:
target_find_dependencies(my_lib PRIVATE_CONFIG fmt)

# Link dependencies:
target_link_system_libraries(my_lib PRIVATE fmt::fmt)

if(FEATURE_TESTS)
  add_subdirectory("./test")
endif()
