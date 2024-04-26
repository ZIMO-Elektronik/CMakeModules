cmake_minimum_required(VERSION 3.25 FATAL_ERROR)
include(FetchContent)

# Prepend CMakeModules path to CMAKE_MODULE_PATH
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake ${CMAKE_MODULE_PATH})
get_directory_property(HAS_PARENT_DIRECTORY PARENT_DIRECTORY)
if(HAS_PARENT_DIRECTORY)
  set(CMAKE_MODULE_PATH
      ${CMAKE_MODULE_PATH}
      PARENT_SCOPE)
endif()

# Implicitly include CPM
if(NOT cpm.cmake_SOURCE_DIR)
  FetchContent_Declare(
    CPM.cmake
    GIT_REPOSITORY "https://github.com/cpm-cmake/CPM.cmake.git"
    GIT_TAG v0.39.0)
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

# Might get included before a top level project call, check directory as well
if(PROJECT_IS_TOP_LEVEL AND CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  include(CTest)
endif()

if(BUILD_TESTING AND CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  add_subdirectory(tests)
endif()
