add_library_test(my_lib tests CONFIGS common SOURCES tests.cpp)

# constexpr tests
add_subdirectory("./constexpr")