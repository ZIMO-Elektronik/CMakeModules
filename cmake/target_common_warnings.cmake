#[[
MIT License

Copyright (c) 2025 ZIMO Elektronik

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

function(target_common_warnings TARGET SCOPE)
  # Common warnings for both C and C++
  set(COMMON_WARNINGS
      -Wall
      -Wcast-align
      -Wcast-qual
      -Wconversion
      -Wdouble-promotion
      -Wextra
      -Wfloat-equal
      -Wformat=2
      -Wmisleading-indentation
      -Wnull-dereference
      -Wpedantic
      -Wshadow
      -Wsign-conversion
      -Wundef
      -Wunused)

  # C-only warnings
  set(C_WARNINGS -Wmissing-declarations -Wstrict-prototypes -Wvla)

  # C++-only warnings
  set(CXX_WARNINGS
      -Wdelete-non-virtual-dtor
      -Wextra-semi
      -Wnon-virtual-dtor
      -Wold-style-cast
      -Woverloaded-virtual
      -Wself-move
      -Wsuggest-override
      -Wzero-as-null-pointer-constant)

  # GCC-specific warnings
  if(CMAKE_C_COMPILER_ID MATCHES GNU)
    list(APPEND COMMON_WARNINGS -Wduplicated-branches -Wduplicated-cond
         -Wlogical-op)
  endif()
  if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    list(APPEND CXX_WARNINGS -Wclass-memaccess -Wuseless-cast)
  endif()

  # Clang-specific warnings
  if(CMAKE_CXX_COMPILER_ID MATCHES Clang)
    list(
      APPEND
      CXX_WARNINGS
      -Wcovered-switch-default
      -Wextra-semi-stmt
      -Wnewline-eof
      -Wself-assign
      -Wundefined-func-template)
  endif()

  target_compile_options(
    ${TARGET} ${SCOPE} ${COMMON_WARNINGS}
    "$<$<COMPILE_LANGUAGE:C>:${C_WARNINGS}>"
    "$<$<COMPILE_LANGUAGE:CXX>:${CXX_WARNINGS}>")

  # If further arguments passed, forward
  target_compile_options(${TARGET} ${SCOPE} ${ARGN})
endfunction()
