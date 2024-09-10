add_library(my_lib "./src/my_lib/lib.cpp")

# cmake-format: off
target_sources(
  my_lib PUBLIC
    FILE_SET HEADERS
    BASE_DIRS include
    FILES include/my_lib/lib.hpp
)
# cmake-format: on

# link project_options/warnings
target_link_libraries(my_lib PRIVATE my_project_options my_project_warnings)

# Includes not needed if using FILE_SET HEADERS
#XXX target_include_interface_directories(my_lib include)

# Find dependencies:
target_find_dependencies(my_lib PRIVATE_CONFIG fmt)

# Link dependencies:
target_link_system_libraries(my_lib PRIVATE fmt::fmt)

if(FEATURE_TESTS)
  add_subdirectory("./test")
endif()
