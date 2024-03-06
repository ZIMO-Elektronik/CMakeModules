cmake_minimum_required(VERSION 3.25 FATAL_ERROR)
include(FetchContent)

# Append CMakeModules path to CMAKE_MODULE_PATH
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR}/cmake)
set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    PARENT_SCOPE)

#
if(NOT cpm.cmake_SOURCE_DIR)
  FetchContent_Declare(
    CPM.cmake
    GIT_REPOSITORY https://github.com/cpm-cmake/CPM.cmake.git
    GIT_TAG v0.38.7)
  FetchContent_MakeAvailable(CPM.cmake)
  include(${cpm.cmake_SOURCE_DIR}/cmake/CPM.cmake)
endif()

include(cmake/add_clang_format_target.cmake)
include(cmake/add_compile_link_options.cmake)
include(cmake/build_qt.cmake)
include(cmake/find_qt.cmake)
include(cmake/minify_html.cmake)
include(cmake/sanitize.cmake)
include(cmake/target_common_warnings.cmake)
include(cmake/target_compile_link_options.cmake)
include(cmake/target_unity_build.cmake)
include(cmake/version_from_git.cmake)

version_from_git()
project(CMakeModules VERSION ${VERSION_FROM_GIT})

option(CMAKEMODULES_BUILD_TESTING "" OFF)

if(CMAKEMODULES_BUILD_TESTING)
  include(CTest)
  add_subdirectory(tests)
endif()
