# Changelog

## 0.8.0
- Add build_qt
- Add FindCQtDeployer file

## 0.7.0
- Add add_compile_link_options
- CPM gets added implicitly
- Change sanitize to macro

## 0.6.1
- Default BUILD_TESTING=OFF

## 0.6.0
- Add get_cqtdeployer

## 0.5.0
- Add find_qt

## 0.4.1
- version_from_git defaults to 0.0.0 if git describe --tags errors 

## 0.4.0
- Add x86_64-w64-mingw32 toolchain file

## 0.3.0
- Add add_clang_format_target

## 0.2.2
- Update to CPM 0.38.6

## 0.2.1
- Fix target_compile_link_options

## 0.2.0
- Fix spelling of sanitize

## 0.1.2
- `-Werror=` argument `-Werror=implicit-function-declaration` is not valid for C++

## 0.1.1
- Add `-Werror-implicit-function-declaration` to target_common_warnings

## 0.1.0
- Add a whole bunch of `-Werror` flags to target_common_warnings
- Remove target_suppress_warnings (superseded by [FetchContent_Declare](https://cmake.org/cmake/help/latest/module/FetchContent.html) SYSTEM option)

## 0.0.7
- Add METADATA to version_from_git

## 0.0.6
- Add version_from_git

## 0.0.5
- Remove fetchcontent_declare_unique

## 0.0.4
- Add gcc-12 toolchain file

## 0.0.3
- Add CPM
- Add minify_html

## 0.0.2
- Add target_unity_build

## 0.0.1
- Initial release