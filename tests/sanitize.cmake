sanitize(address,undefined)

string(FIND ${CMAKE_C_FLAGS} "-fsanitize=address,undefined" fsanitize_POS)
if(fsanitize_POS EQUAL -1)
  message(FATAL_ERROR "CMAKE_C_FLAGS does not contain -fsanitize")
endif()
