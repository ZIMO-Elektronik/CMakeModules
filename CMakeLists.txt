cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

include(modules/cpm.cmake)
include(modules/fetchcontent_declare_unique.cmake)
include(modules/minify_html.cmake)
include(modules/sanatize.cmake)
include(modules/target_common_warnings.cmake)
include(modules/target_compile_link_options.cmake)
include(modules/target_suppress_warnings.cmake)
include(modules/target_unity_build.cmake)

project(CMakeModules VERSION 0.0.1)
