cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

include(cmake/add_clang_format_target.cmake)
include(cmake/find_qt.cmake)
include(cmake/get_cpm.cmake)
include(cmake/get_cqtdeployer.cmake)
include(cmake/minify_html.cmake)
include(cmake/sanitize.cmake)
include(cmake/target_common_warnings.cmake)
include(cmake/target_compile_link_options.cmake)
include(cmake/target_unity_build.cmake)
include(cmake/version_from_git.cmake)

version_from_git()
project(CMakeModules VERSION ${VERSION_FROM_GIT})

option(BUILD_TESTING "" OFF)

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  include(CTest)
endif()

if(BUILD_TESTING
   AND CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME
   AND CMAKE_SYSTEM_NAME STREQUAL CMAKE_HOST_SYSTEM_NAME)
  add_subdirectory(tests)
endif()
