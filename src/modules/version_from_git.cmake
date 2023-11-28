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

function(version_from_git)
  find_package(Git)

  # Run git describe --tags
  execute_process(
    COMMAND ${GIT_EXECUTABLE} describe --tags
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_OUTPUT
    ERROR_VARIABLE GIT_ERROR
    OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_STRIP_TRAILING_WHITESPACE)

  # Error defaults to 0.0.0, otherwise find semantic version in output
  if(GIT_ERROR)
    message(WARNING "git describe --tags failed, default to 0.0.0")
    set(VERSION_MAJOR 0)
    set(VERSION_MINOR 0)
    set(VERSION_PATCH 0)
    set(VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH})
  elseif(
    GIT_OUTPUT
    MATCHES
    "^v(0|[1-9][0-9]*)[.](0|[1-9][0-9]*)[.](0|[1-9][0-9]*)(-[.0-9A-Za-z-]+)?([+][.0-9A-Za-z-]+)?$"
  )
    set(VERSION_MAJOR ${CMAKE_MATCH_1})
    set(VERSION_MINOR ${CMAKE_MATCH_2})
    set(VERSION_PATCH ${CMAKE_MATCH_3})
    set(VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH})
    set(IDENTIFIERS ${CMAKE_MATCH_4})
    set(METADATA ${CMAKE_MATCH_5})
  else()
    message(FATAL_ERROR "${GIT_OUTPUT} isn't valid semantic version")
  endif()

  # Set variables in PARENT_SCOPE
  set(VERSION_MAJOR_FROM_GIT
      ${VERSION_MAJOR}
      PARENT_SCOPE)
  set(VERSION_MINOR_FROM_GIT
      ${VERSION_MINOR}
      PARENT_SCOPE)
  set(VERSION_PATCH_FROM_GIT
      ${VERSION_PATCH}
      PARENT_SCOPE)
  set(VERSION_FROM_GIT
      ${VERSION}
      PARENT_SCOPE)
  set(IDENTIFIERS_FROM_GIT
      ${IDENTIFIERS}
      PARENT_SCOPE)
  set(METADATA_FROM_GIT
      ${METADATA}
      PARENT_SCOPE)
endfunction()
