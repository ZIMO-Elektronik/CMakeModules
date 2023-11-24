#[[
MIT License

Copyright (c) 2023 ZIMO Elektronik

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

set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Find x86_64-w64-mingw32-gcc
set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)

# Root path
set(CMAKE_FIND_ROOT_PATH /usr/x86_64-w64-mingw32)

# Search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# For libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Make sure Qt can be detected by CMake
set(QT_BINARY_DIR /usr/x86_64-w64-mingw32/bin /usr/bin)
set(QT_INCLUDE_DIRS_NO_SYSTEM ON)
set(QT_HOST_PATH
    "/usr"
    CACHE PATH "host path for Qt")

# Set the resource compiler (RHBZ #652435)
set(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)
set(CMAKE_MC_COMPILER x86_64-w64-mingw32-windmc)

# Override boost thread component suffix as mingw-w64-boost is compiled with
# threadapi=win32
set(Boost_THREADAPI win32)

# These are needed for compiling lapack (RHBZ #753906)
set(CMAKE_Fortran_COMPILER x86_64-w64-mingw32-gfortran)
set(CMAKE_AR:FILEPATH x86_64-w64-mingw32-ar)
set(CMAKE_RANLIB:FILEPATH x86_64-w64-mingw32-ranlib)
