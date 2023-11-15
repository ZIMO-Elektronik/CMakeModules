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

function(target_common_warnings TARGET SCOPE)
  # Set common warnings
  set(C_CXX_WARNINGS
      -Wall;-Wextra;-Wshadow;-Wunused;-Wcast-align;-Wpedantic;-Wconversion;-Wsign-conversion;-Wmisleading-indentation;-Wnull-dereference;-Wdouble-promotion;-Wfatal-errors;
  )
  set(CXX_WARNINGS
      "$<$<COMPILE_LANGUAGE:CXX>:-Wnon-virtual-dtor;-Wold-style-cast;-Wsuggest-override;-Woverloaded-virtual>"
  )
  set(GNU_WARNINGS
      "$<$<CXX_COMPILER_ID:GNU>:-Wduplicated-cond;-Wduplicated-branches;-Wlogical-op>"
  )
  set(GNU_CXX_WARNINGS "$<$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wuseless-cast>")

  # Make some errors
  set(C_ERRORS "$<$<COMPILE_LANGUAGE:C>:-Werror-implicit-function-declaration>")
  set(C_CXX_ERRORS
      -Werror=array-bounds;-Werror=array-compare;-Werror=dangling-else;-Werror=implicit-fallthrough;-Werror=parentheses;-Werror=infinite-recursion;-Werror=logical-not-parentheses;-Werror=misleading-indentation;-Werror=return-type;-Werror=sequence-point;-Werror=shift-negative-value;-Werror=shift-overflow;-Werror=sizeof-array-div;-Werror=strict-aliasing;-Werror=tautological-compare;-Werror=type-limits
  )

  target_compile_options(
    ${TARGET}
    ${SCOPE}
    ${C_CXX_WARNINGS}
    ${CXX_WARNINGS}
    ${GNU_WARNINGS}
    ${GNU_CXX_WARNINGS}
    ${C_ERRORS}
    ${C_CXX_ERRORS})

  # If further arguments passed, forward
  target_compile_options(${TARGET} ${SCOPE} ${ARGN})
endfunction()
