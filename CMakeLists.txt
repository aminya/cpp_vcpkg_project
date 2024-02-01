cmake_minimum_required(VERSION 3.21...3.27)

# set a default CXX standard for the tools and targets that do not specify them.
# If commented, the latest supported standard for your compiler is automatically set.
# set(CMAKE_CXX_STANDARD 20)

include(FetchContent)
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
  cmake_policy(SET CMP0135 NEW)
endif()

# Add project_options from https://github.com/aminya/project_options
# Change the version in the following URL to update the package (watch the releases of the repository for future updates)
set(PROJECT_OPTIONS_VERSION "v0.33.1")
FetchContent_Declare(
  _project_options
  URL https://github.com/aminya/project_options/archive/refs/tags/${PROJECT_OPTIONS_VERSION}.zip)

FetchContent_MakeAvailable(_project_options)
include(${_project_options_SOURCE_DIR}/Index.cmake)

# Define the features of the project
include("./Features.cmake")

# enable cross-compiling: - should be called before run_vcpkg()
if(ENABLE_CROSS_COMPILING)
  enable_cross_compiler()
endif()

# install vcpkg dependencies: - should be called before defining project()
run_vcpkg(
    VCPKG_URL "https://github.com/microsoft/vcpkg.git"
    VCPKG_REV "10e052511428d6b0c7fcc63a139e8024bb146032"
)

# Set the project name and language
project(
  cpp_vcpkg_project
  VERSION 1.1.0
  DESCRIPTION ""
  HOMEPAGE_URL "https://github.com/aminya/cpp_vcpkg_project"
  LANGUAGES CXX C)

if(FEATURE_TESTS)
  # enable sanitizers and analyzers if running the tests
  set(ENABLE_CLANG_TIDY "ENABLE_CLANG_TIDY")
  set(ENABLE_CPPCHECK "ENABLE_CPPCHECK")
  set(ENABLE_COVERAGE "ENABLE_COVERAGE")
  set(ENABLE_VS_ANALYSIS "ENABLE_VS_ANALYSIS")

  check_sanitizers_support(
    ENABLE_SANITIZER_ADDRESS
    ENABLE_SANITIZER_UNDEFINED_BEHAVIOR
    ENABLE_SANITIZER_LEAK
    ENABLE_SANITIZER_THREAD
    ENABLE_SANITIZER_MEMORY)

  # generate a main function for the test executable
  enable_testing()
  add_library(catch2_test_common INTERFACE)
  target_find_dependencies(catch2_test_common INTERFACE_CONFIG Catch2)
  target_link_libraries(catch2_test_common INTERFACE Catch2::Catch2 Catch2::Catch2WithMain)
  target_compile_definitions(catch2_test_common INTERFACE DO_NOT_USE_WMAIN)
  include(Catch)
endif()

if(FEATURE_DOCS)
  set(ENABLE_DOXYGEN "ENABLE_DOXYGEN")
endif()

# Initialize project_options variable related to this project
# This overwrites `project_options` and sets `project_warnings`
# uncomment to enable the options. Some of them accept one or more inputs:
project_options(
  PREFIX
  "my"
  ENABLE_CACHE
  ${ENABLE_CPPCHECK}
  ${ENABLE_CLANG_TIDY}
  ${ENABLE_VS_ANALYSIS}
  # ENABLE_CONAN
  # ENABLE_INTERPROCEDURAL_OPTIMIZATION
  # ENABLE_NATIVE_OPTIMIZATION
  ${ENABLE_DOXYGEN}
  ${ENABLE_COVERAGE}
  ${ENABLE_SANITIZER_ADDRESS}
  ${ENABLE_SANITIZER_UNDEFINED_BEHAVIOR}
  # ${ENABLE_SANITIZER_THREAD}
  # ${ENABLE_SANITIZER_MEMORY}
  # ENABLE_CONTROL_FLOW_PROTECTION
  # ENABLE_STACK_PROTECTION
  # ENABLE_OVERFLOW_PROTECTION
  # ENABLE_ELF_PROTECTION
  # ENABLE_RUNTIME_SYMBOLS_RESOLUTION
  # ENABLE_COMPILE_COMMANDS_SYMLINK
  # ENABLE_PCH
  # PCH_HEADERS
  # WARNINGS_AS_ERRORS
  # ENABLE_INCLUDE_WHAT_YOU_USE
  # ENABLE_GCC_ANALYZER
  # ENABLE_BUILD_WITH_TIME_TRACE
  # ENABLE_UNITY
  # LINKER "lld"
  # CONAN_PROFILE ${profile_path}
)

add_subdirectory(./my_exe)
add_subdirectory(./my_lib)
add_subdirectory(./my_header_lib)

# the variables set using CACHE STRING "" are passed to package_project

# Package the project
package_project(
  TARGETS
  my_exe
  my_lib
  my_header_lib
  my_project_options
  my_project_warnings)

if(FEATURE_FUZZ_TESTS)
  add_subdirectory(fuzz_test)
endif()

# set the startup project for the "play" button in MSVC
set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT my_exe)

# Experience shows that explicit package naming can help make it easier to sort
# out potential ABI related issues before they start, while helping you
# track a build to a specific GIT SHA
set(CPACK_PACKAGE_FILE_NAME
    "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}-${GIT_SHORT_SHA}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}"
)

include(CPack)
