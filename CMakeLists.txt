cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

include(src/modules/cpm.cmake)
include(src/modules/minify_html.cmake)
include(src/modules/sanatize.cmake)
include(src/modules/target_common_warnings.cmake)
include(src/modules/target_compile_link_options.cmake)
include(src/modules/target_suppress_warnings.cmake)
include(src/modules/target_unity_build.cmake)
include(src/modules/version_from_git.cmake)

version_from_git()
project(CMakeModules VERSION ${VERSION_FROM_GIT})

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  include(CTest)
endif()

if(BUILD_TESTING
   AND CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME
   AND CMAKE_SYSTEM_NAME STREQUAL CMAKE_HOST_SYSTEM_NAME)
  add_subdirectory(tests)
endif()
