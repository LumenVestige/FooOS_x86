rm -rf build
cmake -S . -B build
cmake --build build
cmake --build build --target run
#cmake -P run.cmake

