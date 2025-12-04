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

function(add_include_what_you_must_target NAME)
  set(ONE_VALUE_KEYWORDS TARGET)
  set(MULTI_VALUE_KEYWORDS EXCLUDE_HEADERS)
  cmake_parse_arguments(ARG "" "${ONE_VALUE_KEYWORDS}"
                        "${MULTI_VALUE_KEYWORDS}" "${ARGN}")

  get_target_property(INC_DIRS ${ARG_TARGET} INCLUDE_DIRECTORIES)
  get_target_property(INTF_INC_DIRS ${ARG_TARGET} INTERFACE_INCLUDE_DIRECTORIES)
  get_target_property(INTF_SYS_INC_DIRS ${ARG_TARGET}
                      INTERFACE_SYSTEM_INCLUDE_DIRECTORIES)
  list(APPEND INC_DIRS ${INTF_INC_DIRS} ${INTF_SYS_INC_DIRS})

  set(ALL_C_HEADERS "")
  set(ALL_CXX_HEADERS "")
  foreach(DIR IN LISTS INC_DIRS)
    file(GLOB_RECURSE C_INCS ${DIR}/*.h)
    list(APPEND ALL_C_HEADERS ${C_INCS})
    file(GLOB_RECURSE CXX_INCS ${DIR}/*.hpp ${DIR}/*.hh ${DIR}/*.hxx)
    list(APPEND ALL_CXX_HEADERS ${CXX_INCS})
  endforeach()
  list(REMOVE_DUPLICATES ALL_C_HEADERS)
  list(REMOVE_DUPLICATES ALL_CXX_HEADERS)

  set(C_HEADERS "")
  foreach(HEADER IN LISTS ALL_C_HEADERS)
    set(SKIP FALSE)
    foreach(EXCLUDE_HEADER IN LISTS ARG_EXCLUDE_HEADERS)
      string(FIND "${HEADER}" "${EXCLUDE_HEADER}" POS)
      if(POS GREATER -1)
        set(SKIP TRUE)
        break()
      endif()
    endforeach()
    if(NOT SKIP)
      list(APPEND C_HEADERS "${HEADER}")
    endif()
  endforeach()

  set(CXX_HEADERS "")
  foreach(HEADER IN LISTS ALL_CXX_HEADERS)
    set(SKIP FALSE)
    foreach(EXCLUDE_HEADER IN LISTS ARG_EXCLUDE_HEADERS)
      string(FIND "${HEADER}" "${EXCLUDE_HEADER}" POS)
      if(POS GREATER -1)
        set(SKIP TRUE)
        break()
      endif()
    endforeach()
    if(NOT SKIP)
      list(APPEND CXX_HEADERS "${HEADER}")
    endif()
  endforeach()

  if(C_HEADERS STREQUAL "" AND CXX_HEADERS STREQUAL "")
    message(FATAL_ERROR "Target ${ARG_TARGET} has no headers")
    return()
  endif()

  set(C_SRCS "")
  foreach(HEADER IN LISTS C_HEADERS)
    set(SRC ${CMAKE_CURRENT_BINARY_DIR}/include_what_you_must/${HEADER}.c)
    file(WRITE ${SRC} "#include \"${HEADER}\"")
    list(APPEND C_SRCS ${SRC})
  endforeach()

  set(CXX_SRCS "")
  foreach(HEADER IN LISTS CXX_HEADERS)
    set(SRC ${CMAKE_CURRENT_BINARY_DIR}/include_what_you_must/${HEADER}.cpp)
    file(WRITE ${SRC} "#include \"${HEADER}\"")
    list(APPEND CXX_SRCS ${SRC})
  endforeach()

  add_library(${NAME} STATIC ${C_SRCS} ${CXX_SRCS})
  target_link_libraries(${NAME} PRIVATE ${ARG_TARGET})
endfunction()
