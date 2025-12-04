file(DOWNLOAD
     "https://github.com/ZIMO-Elektronik/.github/raw/master/data/.clang-format"
     ${CMAKE_CURRENT_SOURCE_DIR}/.clang-format)
file(GLOB_RECURSE SRC *.cpp)
add_clang_format_target(CMakeModulesFormat OPTIONS -i FILES ${SRC})
