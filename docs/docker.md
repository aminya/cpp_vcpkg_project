## Docker Instructions

If you have [Docker](https://www.docker.com/) installed, you can run this
in your terminal, when the Dockerfile is inside the `.devcontainer` directory:

```bash
docker build -f ./.devcontainer/Dockerfile --tag=devcontainer:latest .
docker run -it devcontainer:latest
```

This command will put you in a `bash` session in a Ubuntu 22.04 Docker container,
with all of the tools listed in the [Dependencies](#dependencies) section already installed.
Additionally, you will have `g++-13` and `clang++-13` installed as the default
versions of `g++` and `clang++`.

If you want to build this container using some other versions of gcc and clang,
you may do so with the `GCC_VER` and `LLVM_VER` arguments:

```bash
docker build --tag=myproject:latest --build-arg GCC_VER=10 --build-arg LLVM_VER=15 .
```

The CC and CXX environment variables are set to GCC version 13 by default.
If you wish to use clang as your default CC and CXX environment variables, you
may do so like this:

```bash
docker build --tag=devcontainer:latest --build-arg USE_CLANG=1 .
```

You will be logged in as root, so you will see the `#` symbol as your prompt.
You will be in a directory that contains a copy of the `cpp_vcpkg_project`;
any changes you make to your local copy will not be updated in the Docker image
until you rebuild it.
If you need to mount your local copy directly in the Docker image, see
[Docker volumes docs](https://docs.docker.com/storage/volumes/).
TLDR:

```bash
docker run -it \
	-v absolute_path_on_host_machine:absolute_path_in_guest_container \
	devcontainer:latest
```

You can configure and build [as directed above](#build) using these commands:

```bash
/cpp_vcpkg_project# cmake --workflow --preset gcc-debug
/cpp_vcpkg_project# mkdir -p build/coverage
/cpp_vcpkg_project# gcovr
```

You can configure and build using `clang-15`, without rebuilding the container,
with these commands:

```bash
/cpp_vcpkg_project# cmake --workflow --preset clang-relase
```

All of the tools this project supports are installed in the Docker image;
enabling them is as simple as flipping a switch using the `ccmake` interface.

