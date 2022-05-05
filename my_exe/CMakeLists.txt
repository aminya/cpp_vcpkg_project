add_executable(my_exe "./src/main.cpp")
target_link_libraries(my_exe PRIVATE project_options project_warnings) # link project_options/warnings

# Includes
# because my_exe includes are private, it uses absolute paths.
set(my_exe_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include" PARENT_SCOPE)
target_include_directories(my_exe PRIVATE "${my_exe_INCLUDE_DIR}")

# Find dependencies:
set(my_exe_DEPENDENCIES_CONFIGURED fmt PARENT_SCOPE)

foreach(DEPENDENCY ${my_exe_DEPENDENCIES_CONFIGURED})
  find_package(${DEPENDENCY} CONFIG REQUIRED)
endforeach()

# Link dependencies
set(my_exe_LINKED_LIBRARIES fmt::fmt)
target_link_system_libraries(my_exe PRIVATE ${my_exe_LINKED_LIBRARIES})

if(FEATURE_TESTS)
  add_subdirectory("./test")
endif()
