build_qt(
  6.6.1
  MODULES
  qtbase
  qtsvg
  CMAKE_OPTIONS
  -DCMAKE_BUILD_TYPE=Release
  -DBUILD_SHARED_LIBS=ON)

find_qt(REQUIRED COMPONENTS Core)
