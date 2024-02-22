#[[
MIT License

Copyright (c) 2024 ZIMO Elektronik

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

# Do not try to compile a full blown executable as this would depend on standard
# C and syscalls
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_SYSTEM_NAME Target)

# Find arm-none-eabi
find_program(ARM_NONE_EABI_C_COMPILER arm-none-eabi-gcc)
find_program(ARM_NONE_EABI_CXX_COMPILER arm-none-eabi-g++)

# Find clang
find_program(C_COMPILER clang)
find_program(CXX_COMPILER clang++)
find_program(AR llvm-ar)
find_program(OBJCOPY llvm-objcopy)
find_program(OBJDUMP llvm-objdump)
find_program(SIZE llvm-size)

set(CMAKE_ASM_COMPILER ${C_COMPILER})
set(CMAKE_C_COMPILER ${C_COMPILER})
set(CMAKE_CXX_COMPILER ${CXX_COMPILER})
set(CMAKE_AR ${AR})
set(CMAKE_OBJCOPY ${OBJCOPY})
set(CMAKE_OBJDUMP ${OBJDUMP})
set(CMAKE_SIZE ${SIZE})

# Clang target triple
set(COMPILER_TARGET arm-none-eabi)
set(CMAKE_ASM_COMPILER_TARGET ${COMPILER_TARGET})
set(CMAKE_C_COMPILER_TARGET ${COMPILER_TARGET})
set(CMAKE_CXX_COMPILER_TARGET ${COMPILER_TARGET})

set(CMAKE_TRY_COMPILE_PLATFORM_VARIABLES ARCH)
if(NOT DEFINED ARCH)
  message(FATAL_ERROR "Unknown architecture")
endif()

set(CMAKE_ASM_FLAGS "${ARCH} -x assembler-with-cpp")
set(CMAKE_C_FLAGS "${ARCH}")
set(CMAKE_CXX_FLAGS "${ARCH}")
set(CMAKE_C_FLAGS_DEBUG "-Og -g")
set(CMAKE_CXX_FLAGS_DEBUG "-Og -g")
set(CMAKE_C_FLAGS_RELEASE "-DNDEBUG -Os -g")
set(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG -Os -g")
set(CMAKE_C_FLAGS_RELWITHDEBINFO "-Os -g")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-Os -g")
set(CMAKE_C_FLAGS_MINSIZEREL ${CMAKE_C_FLAGS_RELEASE})
set(CMAKE_CXX_FLAGS_MINSIZEREL ${CMAKE_CXX_FLAGS_RELEASE})

# Set CMAKE_SYSROOT from arm-none-eabi-gcc -print-sysroot output
separate_arguments(ARCH_LIST NATIVE_COMMAND ${ARCH})
execute_process(
  COMMAND ${ARM_NONE_EABI_C_COMPILER} ${ARCH_LIST} -print-sysroot
  OUTPUT_VARIABLE CMAKE_SYSROOT
  OUTPUT_STRIP_TRAILING_WHITESPACE)

# Get list of include paths (https://stackoverflow.com/a/59068162/5840652)
execute_process(
  COMMAND ${ARM_NONE_EABI_C_COMPILER} ${ARCH_LIST} -Wp,-v -x c++ - -fsyntax-only
  TIMEOUT 1
  ERROR_VARIABLE ARM_NONE_EABI_INC_DIRS
  OUTPUT_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)

# Add include paths
include_directories(${CMAKE_SYSROOT}/include)
separate_arguments(ARM_NONE_EABI_INC_DIRS_LIST NATIVE_COMMAND
                   ${ARM_NONE_EABI_INC_DIRS})
foreach(DIR ${ARM_NONE_EABI_INC_DIRS_LIST})
  string(REGEX MATCH "([0-9]+)\\.([0-9]+)\\.([0-9]+)" CONTAINS_VERSION ${DIR})
  if(NOT ${CONTAINS_VERSION} STREQUAL "")
    include_directories(${DIR})
  endif()
endforeach()

# Replace Clang with GCC as linker driver
set(CMAKE_C_LINK_EXECUTABLE
    "${ARM_NONE_EABI_C_COMPILER} <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
)
set(CMAKE_CXX_LINK_EXECUTABLE
    "${ARM_NONE_EABI_CXX_COMPILER} <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
)
