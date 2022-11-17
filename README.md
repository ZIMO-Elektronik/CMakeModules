# CMakeModules

<img src="data/images/logo.png" width="15%" align="right"/>

CMakeModules bundles CMake modules and toolchain files.

### Modules
- fetchcontent_declare_unique  
  Wrapper around CMake's very own [FetchContent_Declare](https://cmake.org/cmake/help/latest/module/FetchContent.html) command. In case a GIT_REPOSITORY is checked out multiple times with different GIT_TAGs an error is thrown. This is still far from package managing but at least it doesn't compile...
  ```cmake
  fetchcontent_declare_unique(
    GSL
    GIT_REPOSITORY https://github.com/microsoft/GSL.git
    GIT_TAG v4.0.0)
  FetchContent_MakeAvailable(GSL)
  ```

- minify_html  
  Minify HTML code by removing comments, newlines and whitespaces.
  ```cmake
  minify_html(index.html ${CMAKE_BINARY_DIR}/index.html)
  ```

- sanatize  
  Add [-fsanitize](https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html) options.
  ```cmake
  sanatize("address,undefined")
  ```

- target_common_warnings  
  Wrapper around [target_compile_options](https://cmake.org/cmake/help/latest/command/target_compile_options.html) which adds a bunch of useful compiler warnings to a target. Can also be called without any further arguments.

- target_compile_link_options
  Wrapper around [target_compile_options](https://cmake.org/cmake/help/latest/command/target_compile_options.html) and [target_link_options](https://cmake.org/cmake/help/latest/command/target_link_options.html). Simply invokes both commands with all arguments.

- target_suppress_warnings  
  Currently suppresses warnings from header files by prepending the SYSTEM keyword to INTERFACE_INCLUDE_DIRECTORIES. Would be great if all errors could be suppressed.

### Toolchain files
- arm_clang  
  Toolchain file to build ARM target with Clang. Build types are defined as follows
  | Build type   | Flags           |
  | ------------ | --------------- |
  | Debug        | -Og -g          |
  | Release      | -DNDEBUG -Os -g |
  | RelWithDebug | -Os -g          |
  | MinSizeRel   | -DNDEBUG -Os -g |

- arm_none_eabi_gcc  
  Toolchain file to build ARM target with arm-none-eabi-gcc. Build types are defined as follows
  | Build type   | Flags           |
  | ------------ | --------------- |
  | Debug        | -Og -g          |
  | Release      | -DNDEBUG -Os -g |
  | RelWithDebug | -Os -g          |
  | MinSizeRel   | -DNDEBUG -Os -g |

- clang  
  Toolchain file to build x86_64 target with Clang. Build types are defined as follows
  | Build type   | Flags           |
  | ------------ | --------------- |
  | Debug        | -O0 -g          |
  | Release      | -DNDEBUG -O3    |
  | RelWithDebug | -O3 -g          |
  | MinSizeRel   | -DNDEBUG -Oz    |