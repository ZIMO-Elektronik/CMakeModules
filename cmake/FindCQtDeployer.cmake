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

# Default to version 1.6.2345
if(CQtDeployer_FIND_VERSION_COMPLETE)
  set(VERSION ${CQtDeployer_FIND_VERSION_COMPLETE})
else()
  set(VERSION 1.6.2345)
endif()

# Default to HOST
if(CQtDeployer_FIND_COMPONENTS)
  set(COMPONENTS ${CQtDeployer_FIND_COMPONENTS})
else()
  set(COMPONENTS ${CMAKE_HOST_SYSTEM_NAME})
endif()

find_package(Git REQUIRED)

# Get SHA1 for downloading releases
execute_process(
  COMMAND ${GIT_EXECUTABLE} ls-remote
          "https://github.com/QuasarApp/CQtDeployer.git" -b v${VERSION}
  OUTPUT_VARIABLE GIT_OUTPUT
  ERROR_VARIABLE GIT_ERROR
  OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_STRIP_TRAILING_WHITESPACE)
string(SUBSTRING ${GIT_OUTPUT} 0 7 SHA1)

if(Linux IN_LIST COMPONENTS)
  # Version check
  if(${VERSION} VERSION_LESS 1.5.4.13)
    message(
      FATAL_ERROR "CQtDeployer versions below 1.5.4.13 not supported for Linux")
  endif()

  # Versions below 1.6.2181 follow an old naming scheme
  if(${VERSION} VERSION_LESS 1.6.2181)
    cpmaddpackage(
      NAME
      cqtdeployer_linux
      URL
      "https://github.com/QuasarApp/CQtDeployer/releases/download/v${VERSION}/CQtDeployer_${VERSION}_Linux_x86_64.zip"
      VERSION
      ${VERSION}
      DOWNLOAD_ONLY
      TRUE)
    set(CQTDEPLOYER_LINUX_EXECUTABLE
        ${cqtdeployer_linux_SOURCE_DIR}/cqtdeployer.sh)
    set(BINARYCREATOR_LINUX_EXECUTABLE
        ${cqtdeployer_linux_SOURCE_DIR}/QIF/binarycreator.sh)
    if(Linux STREQUAL CMAKE_HOST_SYSTEM_NAME)
      set(CQTDEPLOYER_EXECUTABLE ${cqtdeployer_linux_SOURCE_DIR}/cqtdeployer.sh)
      set(BINARYCREATOR_EXECUTABLE
          ${cqtdeployer_linux_SOURCE_DIR}/QIF/binarycreator.sh)
    endif()
  else()
    cpmaddpackage(
      NAME
      cqtdeployer_linux
      URL
      "https://github.com/QuasarApp/CQtDeployer/releases/download/v${VERSION}/CQtDeployer_${VERSION}.${SHA1}_Linux_x86_64.zip"
      VERSION
      ${VERSION}
      DOWNLOAD_ONLY
      TRUE)
    set(CQTDEPLOYER_LINUX_EXECUTABLE
        ${cqtdeployer_linux_SOURCE_DIR}/CQtDeployer.sh)
    set(BINARYCREATOR_LINUX_EXECUTABLE
        ${cqtdeployer_linux_SOURCE_DIR}/QIF/binarycreator)
    if(Linux STREQUAL CMAKE_HOST_SYSTEM_NAME)
      set(CQTDEPLOYER_EXECUTABLE ${cqtdeployer_linux_SOURCE_DIR}/CQtDeployer.sh)
      set(BINARYCREATOR_EXECUTABLE
          ${cqtdeployer_linux_SOURCE_DIR}/QIF/binarycreator)
    endif()
  endif()

  # On Linux we additionally need to add permissions
  file(
    CHMOD_RECURSE
    ${cqtdeployer_linux_SOURCE_DIR}
    PERMISSIONS
    OWNER_READ
    OWNER_WRITE
    OWNER_EXECUTE
    GROUP_READ
    GROUP_EXECUTE
    WORLD_READ
    WORLD_EXECUTE)
endif()

if(Windows IN_LIST COMPONENTS)
  # Version check
  if(${VERSION} VERSION_LESS 1.6.2227)
    message(
      FATAL_ERROR
        "CQtDeployer versions below 1.6.2227 not supported for Windows")
  endif()

  cpmaddpackage(
    NAME
    cqtdeployer_windows
    URL
    "https://github.com/QuasarApp/CQtDeployer/releases/download/v${VERSION}/CQtDeployer_${VERSION}.${SHA1}_Windows_AMD64.zip"
    VERSION
    ${VERSION}
    DOWNLOAD_ONLY
    TRUE)
  set(CQTDEPLOYER_WINDOWS_EXECUTABLE
      ${cqtdeployer_windows_SOURCE_DIR}/CQtDeployer.bat)
  set(BINARYCREATOR_WINDOWS_EXECUTABLE
      ${cqtdeployer_windows_SOURCE_DIR}/QIF/binarycreator.exe)
  if(Windows STREQUAL CMAKE_HOST_SYSTEM_NAME)
    set(CQTDEPLOYER_EXECUTABLE
        ${cqtdeployer_windows_SOURCE_DIR}/CQtDeployer.bat)
    set(BINARYCREATOR_EXECUTABLE
        ${cqtdeployer_windows_SOURCE_DIR}/QIF/binarycreator.exe)
  endif()
endif()
