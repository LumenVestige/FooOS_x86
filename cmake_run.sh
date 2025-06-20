rm -rf build
cmake -S . -B build
cmake --build build
cmake --build build --target boot.img
#cmake -P run.cmake

