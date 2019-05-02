# cmake file for a c++-based interpreter

set(CMAKE_BUILD_TYPE Debug)

add_executable(clox main.c chunk.c memory.c debug.c value.c vm.c)