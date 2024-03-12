# Get CQtDeployer for Linux and Windows
find_package(CQtDeployer 1.6.2337 REQUIRED COMPONENTS Linux Windows)

if(NOT CQTDEPLOYER_EXECUTABLE)
  message(FATAL_ERROR "CQtDeployer for ${CMAKE_HOST_SYSTEM_NAME} not found")
endif()

if(NOT BINARYCREATOR_EXECUTABLE)
  message(FATAL_ERROR "binarycreator for ${CMAKE_HOST_SYSTEM_NAME} not found")
endif()

if(NOT CQTDEPLOYER_LINUX_EXECUTABLE)
  message(FATAL_ERROR "CQtDeployer for Linux not found")
endif()

if(NOT BINARYCREATOR_LINUX_EXECUTABLE)
  message(FATAL_ERROR "binarycreator for Linux not found")
endif()

if(NOT CQTDEPLOYER_WINDOWS_EXECUTABLE)
  message(FATAL_ERROR "CQtDeployer for Windows not found")
endif()

if(NOT BINARYCREATOR_WINDOWS_EXECUTABLE)
  message(FATAL_ERROR "binarycreator for Windows not found")
endif()
