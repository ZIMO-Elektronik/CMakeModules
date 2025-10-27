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

function(target_common_errors TARGET SCOPE)
  # Common errors
  set(COMMON_ERRORS
      -Werror=array-bounds
      -Werror=array-compare
      -Werror=dangling-else
      -Werror=implicit-fallthrough
      -Werror=infinite-recursion
      -Werror=logical-not-parentheses
      -Werror=misleading-indentation
      -Werror=null-dereference
      -Werror=parentheses
      -Werror=return-local-addr
      -Werror=return-type
      -Werror=sequence-point
      -Werror=shift-negative-value
      -Werror=shift-overflow
      -Werror=sizeof-array-div
      -Werror=strict-aliasing
      -Werror=tautological-compare
      -Werror=type-limits)

  # C-only errors
  set(C_ERRORS -Werror=implicit-function-declaration)

  target_compile_options(${TARGET} ${SCOPE} ${COMMON_ERRORS}
                         "$<$<COMPILE_LANGUAGE:C>:${C_ERRORS}>")

  # If further arguments passed, forward
  target_compile_options(${TARGET} ${SCOPE} ${ARGN})
endfunction()
