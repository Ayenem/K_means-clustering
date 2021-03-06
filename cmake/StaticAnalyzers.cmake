option(ENABLE_CPPCHECK "Enable static analysis with cppcheck" OFF)
option(${PROJECT_NAME}_ENABLE_CLANG_TIDY "Builds with clang-tidy, if available. Defaults to ON." ON)
option(ENABLE_INCLUDE_WHAT_YOU_USE "Enable static analysis with include-what-you-use" OFF)

if(ENABLE_CPPCHECK)
  find_program(CPPCHECK cppcheck)
  if(CPPCHECK)
    set(CMAKE_CXX_CPPCHECK
        ${CPPCHECK}
        --suppress=missingInclude
        --enable=all
        --inline-suppr
        --inconclusive
        -i
        ${CMAKE_SOURCE_DIR}/imgui/lib)
  else()
    message(SEND_ERROR "cppcheck requested but executable not found")
  endif()
endif()

if(${PROJECT_NAME}_ENABLE_CLANG_TIDY)
  find_program(CLANG_TIDY_PATH clang-tidy)
  if(CLANG_TIDY_PATH)
    set(CMAKE_CXX_CLANG_TIDY ${CLANG_TIDY_PATH} -extra-arg=-Wno-unknown-warning-option)
    set(CLANG_TIDY_COMMAND "${CLANG_TIDY_PATH};--system-headers")
    message(STATUS "Clang tidy from ${CLANG_TIDY_PATH} is set.")
  else()
    message(SEND_ERROR "clang-tidy requested but executable not found")
  endif()
endif()

if(ENABLE_INCLUDE_WHAT_YOU_USE)
  find_program(INCLUDE_WHAT_YOU_USE include-what-you-use)
  if(INCLUDE_WHAT_YOU_USE)
    set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${INCLUDE_WHAT_YOU_USE})
  else()
    message(SEND_ERROR "include-what-you-use requested but executable not found")
  endif()
endif()

