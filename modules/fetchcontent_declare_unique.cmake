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

include(FetchContent)

function(fetchcontent_declare_unique)
  cmake_parse_arguments(FETCH ${ARGN})
  list(FIND ARGN GIT_REPOSITORY GIT_REPOSITORY_INDEX)
  math(EXPR GIT_REPOSITORY_INDEX "${GIT_REPOSITORY_INDEX}+1")
  list(GET ARGN ${GIT_REPOSITORY_INDEX} GIT_REPOSITORY)
  list(FIND ARGN GIT_TAG GIT_TAG_INDEX)

  # Dependency has GIT_TAG
  if(GIT_TAG_INDEX GREATER -1)
    math(EXPR GIT_TAG_INDEX "${GIT_TAG_INDEX}+1")
    list(GET ARGN ${GIT_TAG_INDEX} GIT_TAG)

    # Get global list of dependencies
    get_property(DEPS_LIST GLOBAL PROPERTY DEPS_LIST_PROPERTY)

    # Check if GIT_REPOSITORY already in list
    list(FIND DEPS_LIST ${GIT_REPOSITORY} GIT_REPOSITORY_INDEX)
    if(GIT_REPOSITORY_INDEX GREATER -1)
      math(EXPR GIT_REPOSITORY_INDEX "${GIT_REPOSITORY_INDEX}+1")
      list(GET DEPS_LIST ${GIT_REPOSITORY_INDEX} PREV_GIT_TAG)
      # Error if GIT_TAG does not match error
      if(NOT GIT_TAG STREQUAL PREV_GIT_TAG)
        message(
          FATAL_ERROR
            "Found two different versions of ${GIT_REPOSITORY}: ${PREV_GIT_TAG} and ${GIT_TAG}"
        )
      endif()
    endif()

    # Append to list of dependencies
    list(APPEND DEPS_LIST ${GIT_REPOSITORY} ${GIT_TAG})
    set_property(GLOBAL PROPERTY DEPS_LIST_PROPERTY ${DEPS_LIST})
  endif()

  FetchContent_Declare(${ARGN})
endfunction()
