# cpp_vcpkg_project

[![ci](https://github.com/aminya/cpp_vcpkg_project/actions/workflows/ci.yml/badge.svg)](https://github.com/aminya/cpp_vcpkg_project/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/aminya/cpp_vcpkg_project/branch/main/graph/badge.svg)](https://codecov.io/gh/aminya/cpp_vcpkg_project)
[![LGTM](https://img.shields.io/lgtm/grade/cpp/github/aminya/cpp_vcpkg_project)](https://lgtm.com/projects/g/aminya/cpp_vcpkg_project/context:cpp)

## About cpp_vcpkg_project
A production-ready C++ project made with CMake, vcpkg, [project_options](https://github.com/aminya/project_options), and [setup-cpp](https://github.com/aminya/setup-cpp)


## More Details

 * [Dependency Setup](./docs/dependencies.md)
 * [Building Details](./docs/building.md)
 * [Docker](./docs/docker.md)

## AddressSanitizer

On Windows, enable AddressSanitizer in a non-Debug configuration so the sanitizer runtime can be
loaded by the test executables:

```sh
cmake -S . -B build -G "Ninja Multi-Config" \
  -DFEATURE_TESTS=ON \
  -DENABLE_SANITIZER_ADDRESS=ENABLE_SANITIZER_ADDRESS
cmake --build build --config RelWithDebInfo
ctest --test-dir build -C RelWithDebInfo --output-on-failure
```

The sample executables and test hosts link `my_project_options`. The pinned `project_options`
revision automatically stages the ASan DLL next to each executable on Windows.
