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

function(add_clang_format_target TARGET)
  set(MULTI_VALUE_KEYWORDS OPTIONS FILES)
  cmake_parse_arguments(ARG "" "" "${MULTI_VALUE_KEYWORDS}" "${ARGN}")

  find_program(CLANG_FORMAT_EXECUTABLE clang-format)

  if(CLANG_FORMAT_EXECUTABLE)
    add_custom_target(
      ${TARGET}
      COMMAND ${CLANG_FORMAT_EXECUTABLE} ${ARG_OPTIONS} ${ARG_FILES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "${CLANG_FORMAT_EXECUTABLE} ${ARG_OPTIONS} ${ARG_FILES}")
  else()
    message(WARNING "clang-format not found, target ${TARGET} not created")
  endif()
endfunction()
