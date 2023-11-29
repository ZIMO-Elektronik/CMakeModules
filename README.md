# CMakeModules

[![tests](https://github.com/ZIMO-Elektronik/CMakeModules/actions/workflows/tests.yml/badge.svg)](https://github.com/ZIMO-Elektronik/CMakeModules/actions/workflows/tests.yml)

<img src="data/images/logo.png" width="15%" align="right"/>

CMakeModules bundles CMake modules and toolchain files.

<details>
  <summary>Table of contents</summary>
  <ol>
    <li><a href="#modules">Modules</a></li>
      <ul>
        <li><a href="#add_clang_format_target">add_clang_format_target</a></li>
        <li><a href="#cpm">cpm</a></li>
        <li><a href="#find_qt">find_qt</a></li>
        <li><a href="#minify_html">minify_html</a></li>
        <li><a href="#sanitize">sanitize</a></li>
        <li><a href="#target_common_warnings">target_common_warnings</a></li>
        <li><a href="#target_compile_link_options">target_compile_link_options</a></li>
        <li><a href="#target_unity_build">target_unity_build</a></li>
        <li><a href="#version_from_git">version_from_git</a></li>
      </ul>
    <li><a href="#toolchain-files">Toolchain files</a></li>
      <ul>
        <li><a href="#arm_clang">arm_clang</a></li>
        <li><a href="#arm_none_eabi_gcc">arm_none_eabi_gcc</a></li>
        <li><a href="#clang">clang</a></li>
        <li><a href="#gcc--gcc-12">gcc / gcc12</a></li>
        <li><a href="#x86_64-w64-mingw32">x86_64-w64-mingw32</a></li>
      </ul>
  </ol>
</details>

## Modules
### add_clang_format_target
Adds a custom target specifically used to run [clang-format](https://clang.llvm.org/docs/ClangFormat.html).
```cmake
add_clang_format_target(<name> OPTIONS [<options...>] FILES [<files...>])

# e.g.
add_clang_format_target(FormatTarget OPTIONS -i --style=llvm FILES main.cpp func.cpp)
```

### cpm
[CPM.cmake](https://github.com/cpm-cmake/CPM.cmake) is a cross-platform CMake script that adds dependency management capabilities to CMake. It's built as a thin wrapper around CMake's [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html) module that adds version control, caching, a simple API [and more](https://github.com/cpm-cmake/CPM.cmake#comparison-to-pure-fetchcontent--externalproject).

### find_qt
Macro which conditionally adds Qt6 or Qt5 components depending on which version is already present in the configuration. If neither Qt6 nor Qt5 is found, the macro tries to add Qt6 first and if this fails, Qt5. This allows libraries to integrate Qt components without having to know the version.
```cmake
find_qt(REQUIRED COMPONENTS Charts Core DataVisualization Widgets)
```

### minify_html
Minify HTML code by removing comments, newlines and whitespaces.
```cmake
minify_html(index.html ${CMAKE_BINARY_DIR}/index.html)
```

### sanitize
Add [-fsanitize](https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html) options to the current directory and below.
```cmake
sanitize("address,undefined")
```

### target_common_warnings
Wrapper around [target_compile_options](https://cmake.org/cmake/help/latest/command/target_compile_options.html) which adds a bunch of useful compiler warnings to a target. Can also be called without any further arguments.

### target_compile_link_options
Wrapper around [target_compile_options](https://cmake.org/cmake/help/latest/command/target_compile_options.html) and [target_link_options](https://cmake.org/cmake/help/latest/command/target_link_options.html). Simply invokes both commands with all arguments.

### target_unity_build
Enables the [UNITY_BUILD](https://cmake.org/cmake/help/latest/prop_tgt/UNITY_BUILD.html) target property and sets [UNITY_BUILD_BATCH_SIZE](https://cmake.org/cmake/help/latest/prop_tgt/UNITY_BUILD_BATCH_SIZE.html#prop_tgt:UNITY_BUILD_BATCH_SIZE) 0.

### version_from_git
The function uses the output of `git describe --tags` to generate a MAJOR.MINOR.PATCH version string. This project versions itself with it.
```cmake
version_from_git()
project(CMakeModules VERSION ${VERSION_FROM_GIT})
```

It sets the following variables:
- VERSION_FROM_GIT
- VERSION_MAJOR_FROM_GIT
- VERSION_MINOR_FROM_GIT
- VERSION_PATCH_FROM_GIT
- IDENTIFIERS_FROM_GIT
- METADATA_FROM_GIT

:warning: GitHub [actions/checkout@v4](https://github.com/actions/checkout) does not automatically checkout tags. You'll need to manually specify that, e.g.
```yml
- uses: actions/checkout@v4
  with:
    fetch-depth: 0
```

## Toolchain files
### arm_clang
Toolchain file to build ARM target with Clang. Build types are defined as follows
| Build type   | Flags           |
| ------------ | --------------- |
| Debug        | -Og -g          |
| Release      | -DNDEBUG -Os -g |
| RelWithDebug | -Os -g          |
| MinSizeRel   | -DNDEBUG -Os -g |

### arm_none_eabi_gcc
Toolchain file to build ARM target with arm-none-eabi-gcc. Build types are defined as follows
| Build type   | Flags           |
| ------------ | --------------- |
| Debug        | -Og -g          |
| Release      | -DNDEBUG -Os -g |
| RelWithDebug | -Os -g          |
| MinSizeRel   | -DNDEBUG -Os -g |

### clang
Toolchain file to build x86_64 target with Clang.

### gcc / gcc-12
Toolchain file to build x86_64 target with GCC / GCC 12.

### x86_64-w64-mingw32
Toolchain file to build x86_64 target with [MinGW](https://www.mingw-w64.org/).