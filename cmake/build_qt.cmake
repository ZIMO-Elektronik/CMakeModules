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

function(build_qt VERSION)
  set(MULTI_VALUE_KEYWORDS MODULES CMAKE_OPTIONS)
  cmake_parse_arguments(ARG "" "" "${MULTI_VALUE_KEYWORDS}" "${ARGN}")

  if(VERSION MATCHES "^(0|[1-9][0-9]*)[.](0|[1-9][0-9]*)[.](0|[1-9][0-9]*)")
    if(${CMAKE_MATCH_1}.${CMAKE_MATCH_2}.${CMAKE_MATCH_3} VERSION_LESS 6.0.0)
      message(FATAL_ERROR "Qt versions below 6.0.0 not supported")
    endif()
  endif()

  # qtbase is mandatory
  if(NOT qtbase IN_LIST ARG_MODULES)
    list(PREPEND ARG_MODULES qtbase)
  endif()

  cpmaddpackage(
    NAME
    qt6
    GIT_REPOSITORY
    https://code.qt.io/qt/qt5.git
    VERSION
    ${VERSION}
    DOWNLOAD_ONLY
    ON
    GIT_SUBMODULES
    ${ARG_MODULES})

  execute_process(
    COMMAND
      ${CMAKE_COMMAND} -Bbuild -GNinja -DCMAKE_INSTALL_PREFIX=${qt6_BINARY_DIR}
      -DQT_DEBUG_FIND_PACKAGE=ON ${ARG_CMAKE_OPTIONS}
    WORKING_DIRECTORY ${qt6_SOURCE_DIR} COMMAND_ECHO STDOUT
                      COMMAND_ERROR_IS_FATAL ANY)

  execute_process(
    COMMAND ${CMAKE_COMMAND} --build ${qt6_SOURCE_DIR}/build --parallel
            COMMAND_ECHO STDOUT COMMAND_ERROR_IS_FATAL ANY)

  execute_process(COMMAND ${CMAKE_COMMAND} --install ${qt6_SOURCE_DIR}/build
                          COMMAND_ECHO STDOUT COMMAND_ERROR_IS_FATAL ANY)

  # Set QT_BINARY_DIR
  set(QT_BINARY_DIR
      ${qt6_BINARY_DIR}
      PARENT_SCOPE)

  # Set Qt6_DIR (https://bugreports.qt.io/browse/QTBUG-97615)
  set(Qt6_DIR
      ${qt6_BINARY_DIR}/lib/cmake/Qt6
      PARENT_SCOPE)

  # Prepend Qt6 path to CMAKE_PREFIX_PATH
  set(CMAKE_PREFIX_PATH
      ${qt6_BINARY_DIR} ${CMAKE_PREFIX_PATH}
      PARENT_SCOPE)

  # Prepend Qt6 path to CMAKE_FIND_ROOT_PATH (in case of cross-compilation)
  set(CMAKE_FIND_ROOT_PATH
      ${qt6_BINARY_DIR} ${CMAKE_FIND_ROOT_PATH}
      PARENT_SCOPE)
endfunction()
