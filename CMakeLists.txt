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

option(CMAKEMODULES_BUILD_TESTING "" OFF)

if(CMAKEMODULES_BUILD_TESTING)
  include(CTest)
  add_subdirectory(tests)
endif()
