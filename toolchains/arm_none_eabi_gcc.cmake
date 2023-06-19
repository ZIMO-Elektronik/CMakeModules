#[[
MIT License

Copyright (c) 2022 ZIMO Elektronik

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
find_program(C_COMPILER arm-none-eabi-gcc)
find_program(CXX_COMPILER arm-none-eabi-g++)
find_program(AR arm-none-eabi-ar)
find_program(OBJCOPY arm-none-eabi-objcopy)
find_program(OBJDUMP arm-none-eabi-objdump)
find_program(SIZE arm-none-eabi-size)

set(CMAKE_ASM_COMPILER ${C_COMPILER})
set(CMAKE_C_COMPILER ${C_COMPILER})
set(CMAKE_CXX_COMPILER ${CXX_COMPILER})
set(CMAKE_AR ${AR})
set(CMAKE_OBJCOPY ${OBJCOPY})
set(CMAKE_OBJDUMP ${OBJDUMP})
set(CMAKE_SIZE ${SIZE})

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
