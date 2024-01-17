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

function(get_cqtdeployer)
  set(multiValueArgs SYSTEMS)
  cmake_parse_arguments(ARG "" "" "${multiValueArgs}" "${ARGN}")

  set(VERSION 1.6.2323)

  # Default to HOST
  if(NOT DEFINED ARG_SYSTEMS)
    set(ARG_SYSTEMS ${CMAKE_HOST_SYSTEM_NAME})
  endif()

  if(Linux IN_LIST ARG_SYSTEMS)
    cpmaddpackage(
      NAME
      cqtdeployer_linux
      URL
      https://github.com/QuasarApp/CQtDeployer/releases/download/v${VERSION}/CQtDeployer_${VERSION}.dd027b2_Linux_x86_64.zip
      VERSION
      ${VERSION}
      DOWNLOAD_ONLY
      TRUE)
    set(CQTDEPLOYER_LINUX_EXECUTABLE
        ${cqtdeployer_linux_SOURCE_DIR}/CQtDeployer.sh
        PARENT_SCOPE)
    set(BINARYCREATOR_LINUX_EXECUTABLE
        ${cqtdeployer_linux_SOURCE_DIR}/QIF/binarycreator
        PARENT_SCOPE)
    if(Linux STREQUAL CMAKE_HOST_SYSTEM_NAME)
      set(CQTDEPLOYER_EXECUTABLE
          ${cqtdeployer_linux_SOURCE_DIR}/CQtDeployer.sh
          PARENT_SCOPE)
      set(BINARYCREATOR_EXECUTABLE
          ${cqtdeployer_linux_SOURCE_DIR}/QIF/binarycreator
          PARENT_SCOPE)

      # On Linux we additionally need to add permissions
      file(
        CHMOD
        ${cqtdeployer_linux_SOURCE_DIR}/CQtDeployer.sh
        ${cqtdeployer_linux_SOURCE_DIR}/bin/CQtDeployer
        ${cqtdeployer_linux_SOURCE_DIR}/QIF/binarycreator
        FILE_PERMISSIONS
        OWNER_READ
        OWNER_WRITE
        OWNER_EXECUTE
        GROUP_READ
        GROUP_EXECUTE
        WORLD_READ
        WORLD_EXECUTE)
    endif()
  endif()

  if(Windows IN_LIST ARG_SYSTEMS)
    cpmaddpackage(
      NAME
      cqtdeployer_windows
      URL
      https://github.com/QuasarApp/CQtDeployer/releases/download/v${VERSION}/CQtDeployer_${VERSION}.dd027b2_Windows_AMD64.zip
      VERSION
      ${VERSION}
      DOWNLOAD_ONLY
      TRUE)
    set(CQTDEPLOYER_WINDOWS_EXECUTABLE
        ${cqtdeployer_windows_SOURCE_DIR}/CQtDeployer.bat
        PARENT_SCOPE)
    set(BINARYCREATOR_WINDOWS_EXECUTABLE
        ${cqtdeployer_windows_SOURCE_DIR}/QIF/binarycreator.exe
        PARENT_SCOPE)
    if(Windows STREQUAL CMAKE_HOST_SYSTEM_NAME)
      set(CQTDEPLOYER_EXECUTABLE
          ${cqtdeployer_windows_SOURCE_DIR}/CQtDeployer.bat
          PARENT_SCOPE)
      set(BINARYCREATOR_EXECUTABLE
          ${cqtdeployer_windows_SOURCE_DIR}/QIF/binarycreator.exe
          PARENT_SCOPE)
    endif()
  endif()
endfunction()
