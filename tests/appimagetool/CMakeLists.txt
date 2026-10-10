# Get appimagetool for host architecture
find_package(appimagetool REQUIRED)

if(NOT CPACK_APPIMAGE_TOOL_EXECUTABLE)
  message(
    FATAL_ERROR "appimagetool for ${CMAKE_HOST_SYSTEM_PROCESSOR} not found")
endif()
