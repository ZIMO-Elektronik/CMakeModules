# CMakeModules

[![tests](https://github.com/ZIMO-Elektronik/CMakeModules/actions/workflows/tests.yml/badge.svg)](https://github.com/ZIMO-Elektronik/CMakeModules/actions/workflows/tests.yml)

<img src="data/images/logo.svg" width="15%" align="right"/>

CMakeModules bundles CMake modules and toolchain files.

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#modules">Modules</a></li>
      <ul>
        <li><a href="#cpmcmake">CPM.cmake</a></li>
        <li><a href="#add_clang_format_target">add_clang_format_target</a></li>
        <li><a href="#add_compile_link_options">add_compile_link_options</a></li>
        <li><a href="#build_qt">build_qt</a></li>
        <li><a href="#find_qt">find_qt</a></li>
        <li><a href="#minify_html">minify_html</a></li>
        <li><a href="#sanitize">sanitize</a></li>
        <li><a href="#target_common_warnings">target_common_warnings</a></li>
        <li><a href="#target_compile_link_options">target_compile_link_options</a></li>
        <li><a href="#target_unity_build">target_unity_build</a></li>
        <li><a href="#version_from_git">version_from_git</a></li>
      </ul>
    <li><a href="#findpackagename-files">Find&lt;PackageName&gt; Files</a></li>
      <ul>
        <li><a href="#findcqtdeployer">FindCQtDeployer</a></li>
      </ul>
    <li><a href="#toolchain-files">Toolchain Files</a></li>
      <ul>
        <li><a href="#toolchain-arm-clang">toolchain-arm-clang</a></li>
        <li><a href="#toolchain-arm-none-eabi-gcc">toolchain-arm-none-eabi-gcc</a></li>
        <li><a href="#toolchain-clang">toolchain-clang</a></li>
        <li><a href="#toolchain-gcc--toolchain-gcc-12">toolchain-gcc--toolchain-gcc-12</a></li>
        <li><a href="#toolchain-x86_64-w64-mingw32-gcc">toolchain-x86_64-w64-mingw32-gcc</a></li>
      </ul>
  </ol>
</details>

## Modules
### CPM.cmake
[CPM.cmake](https://github.com/cpm-cmake/CPM.cmake) is a cross-platform CMake script that adds dependency management capabilities to CMake. It's built as a thin wrapper around CMake's [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html) module that adds version control, caching, a simple API [and more](https://github.com/cpm-cmake/CPM.cmake#comparison-to-pure-fetchcontent--externalproject). The CPM module gets implicitly included.
```cmake
# Use CPM to add a package
CPMAddPackage("gh:fmtlib/fmt#7.1.3")
```

### add_clang_format_target
Adds a custom target specifically used to run [clang-format](https://clang.llvm.org/docs/ClangFormat.html).
```cmake
add_clang_format_target(<name> OPTIONS [options...] FILES [files...])

# e.g.
add_clang_format_target(FormatTarget OPTIONS -i --style=llvm FILES main.cpp func.cpp)
```

### add_compile_link_options
Wrapper around [add_compile_options](https://cmake.org/cmake/help/latest/command/add_compile_options.html) and [add_link_options](https://cmake.org/cmake/help/latest/command/add_link_options.html). Simply invokes both commands with all arguments.

### build_qt
Build [Qt6](https://www.qt.io/) from source. For more information, please read the article [Building Qt 6 from Git](https://wiki.qt.io/Building_Qt_6_from_Git) on the official wiki.
```cmake
build_qt(<version> MODULES [modules...] CMAKE_OPTIONS [cmake_options...])

build_qt(
  6.6.1
  MODULES
  qtbase
  qtsvg
  CMAKE_OPTIONS
  -DCMAKE_BUILD_TYPE=Release
  -DBUILD_SHARED_LIBS=ON)
```

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
Add [-fsanitize](https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html) options starting from current directory and above.
```cmake
sanitize(address,undefined)
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

> [!IMPORTANT]
> GitHub [actions/checkout@v4](https://github.com/actions/checkout) does not automatically checkout tags. You'll need to manually specify that, e.g.
> ```yml
> - uses: actions/checkout@v4
>   with:
>     fetch-depth: 0
> ```

## Find&lt;PackageName&gt; Files
### FindCQtDeployer
[CQtDeployer](https://github.com/QuasarApp/CQtDeployer) is like a cross-platform version of [windeployqt](https://doc.qt.io/qt-6/windows-deployment.html). It helps you to extract all libraries your executable depends on and to create a launch script (or installer) for your application.
```cmake
# Fetch CQtDeployer for Linux
find_package(CQtDeployer 1.6.2337 REQUIRED COMPONENTS Linux)

# Use CQtDeployer to deploy a target
add_custom_command(
  TARGET YourTarget
  POST_BUILD
  COMMAND ${CQTDEPLOYER_EXECUTABLE} -bin $<TARGET_FILE:YourTarget>)
```

## Toolchain Files
### toolchain-arm-clang
Toolchain file to build ARM target with Clang. [`CMAKE_SYSTEM_NAME`](https://cmake.org/cmake/help/latest/variable/CMAKE_SYSTEM_NAME.html) gets set to `Generic`. Build types are defined as follows
| Build type   | Flags           |
| ------------ | --------------- |
| Debug        | -Og -g          |
| Release      | -DNDEBUG -Os -g |
| RelWithDebug | -Os -g          |
| MinSizeRel   | -DNDEBUG -Os -g |

### toolchain-arm-none-eabi-gcc
Toolchain file to build ARM target with arm-none-eabi-gcc. [`CMAKE_SYSTEM_NAME`](https://cmake.org/cmake/help/latest/variable/CMAKE_SYSTEM_NAME.html) gets set to `Generic`. Build types are defined as follows
| Build type   | Flags           |
| ------------ | --------------- |
| Debug        | -Og -g          |
| Release      | -DNDEBUG -Os -g |
| RelWithDebug | -Os -g          |
| MinSizeRel   | -DNDEBUG -Os -g |

### toolchain-clang
Toolchain file to build x86_64 target with Clang.

### toolchain-gcc / toolchain-gcc-12
Toolchain file to build x86_64 target with GCC / GCC 12.

### toolchain-x86_64-w64-mingw32-gcc
Toolchain file to cross-compile x86_64 target with [mingw-w64](https://packages.ubuntu.com/jammy/mingw-w64). This file specifically targets [Ubuntu 22.04](https://releases.ubuntu.com/jammy).