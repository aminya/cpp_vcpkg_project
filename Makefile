# Notes:
# - list all the task under PHONY
# - If getting missing separator error, try replacing spaces with tabs.
# - If using Visual Studio, either run the following commands inside the Visual Studio command prompt (vcvarsall) or remove the Ninja generator from the commands.
.PHONY: build test test_release docs format clean

build:
	cmake ./ -B ./build -G "Ninja Multi-Config" -DCMAKE_BUILD_TYPE:STRING=Release -DFEATURE_TESTS:BOOL=OFF
	cmake --build ./build --config Release

test:
	cmake ./ -B ./build -G "Ninja Multi-Config" -DCMAKE_BUILD_TYPE:STRING=Debug -DFEATURE_TESTS:BOOL=ON
	cmake --build ./build --config Debug

	(cd build/my_exe/test && ctest -C Debug --output-on-failure)

test_release:
	cmake ./ -B ./build -G "Ninja Multi-Config" -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo -DFEATURE_TESTS:BOOL=ON
	cmake --build ./build --config RelWithDebInfo

	(cd build/my_exe/test && ctest -C RelWithDebInfo --output-on-failure)

docs:
	cmake ./ -B ./build -G "Ninja Multi-Config" -DCMAKE_BUILD_TYPE:STRING=Debug -DFEATURE_DOCS:BOOL=ON -DFEATURE_TESTS:BOOL=OFF
	cmake --build ./build --target doxygen-docs --config Debug

format:
ifeq ($(OS), Windows_NT)
	pwsh -c '$$files=(git ls-files --exclude-standard); foreach ($$file in $$files) { if ((get-item $$file).Extension -in ".cpp", ".hpp", ".c", ".cc", ".cxx", ".hxx", ".ixx") { clang-format -i -style=file $$file } }'
else
	git ls-files --exclude-standard | grep -E '\.(cpp|hpp|c|cc|cxx|hxx|ixx)$$' | xargs clang-format -i -style=file
endif

clean:
ifeq ($(OS), Windows_NT)
	pwsh -c 'function rmrf($$path) { if (test-path $$path) { rm -r -force $$path }}; rmrf ./build;'
else
	rm -rf ./build
endif