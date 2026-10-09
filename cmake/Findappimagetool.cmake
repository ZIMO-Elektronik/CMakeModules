#[[
MIT License

Copyright (c) 2026 ZIMO Elektronik

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

if(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64)$")
  set(APPIMAGETOOL_URL
      "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-aarch64.AppImage"
  )
elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^arm")
  set(APPIMAGETOOL_URL
      "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-armhf.AppImage"
  )
elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(i686|i386|x86)$")
  set(APPIMAGETOOL_URL
      "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-i686.AppImage"
  )
elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(x86_64|AMD64)$")
  set(APPIMAGETOOL_URL
      "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"
  )
else()
  message(FATAL_ERROR "Unknown architecture")
endif()

set(APPIMAGE ${CMAKE_CURRENT_BINARY_DIR}/appimagetool/appimagetool.AppImage)
file(DOWNLOAD ${APPIMAGETOOL_URL} ${APPIMAGE})

file(
  CHMOD
  ${APPIMAGE}
  PERMISSIONS
  OWNER_READ
  OWNER_WRITE
  OWNER_EXECUTE
  GROUP_READ
  GROUP_EXECUTE
  WORLD_READ
  WORLD_EXECUTE)

execute_process(
  COMMAND ${APPIMAGE} --appimage-extract
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/appimagetool
  OUTPUT_QUIET)

set(CPACK_APPIMAGE_TOOL_EXECUTABLE
    ${CMAKE_CURRENT_BINARY_DIR}/appimagetool/squashfs-root/AppRun)
