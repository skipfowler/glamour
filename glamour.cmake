cmake_minimum_required(VERSION 3.19)

### glamour.cmake is referenced by all projects using the glamour Loader

function(clone_using_git URL SHA OUT_DIR)
  find_package(git)

  if(NOT GIT_FOUND)
    message(FATAL_ERROR "Unable to find git")
  endif()

  if(NOT EXISTS ${OUT_DIR})
    if(DEFINED ENV{ADO_TOKEN})

    else()
    
    endif()
    
    execute_process(
      COMMAND ${GIT_CLONE_COMMAND}
    )
  endif()
endfunction()

function(switch_checkout_using_git)

endfunction()

# Wrap packages for source are always local
if(IS_WRAP)
  set(IS_LOCAL ON)
endif()

# Setup glamour cloning
#  Get glamour json data
set(GLAMOUR_JSON ${CMAKE_SOURCE_DIR}/.glamour/glamour.json)

if(NOT EXISTS ${GLAMOUR_JSON})
  message(FATAL_ERROR "${GLAMOUR_JSON} does not exist")
endif()

file(READ ${GLAMOUR_JSON} ${GLAMOUR_JSON_DATA})

# Read url from glamour json data
if(DEFINED ADO_TOKEN)
  string(JSON ${GLAMOUR_URL} GET ${GLAMOUR_JSON_DATA} glamour url https)
else()
  string JSON ${GLAMOUR_URL} GET ${GLAMOUR_JSON_DATA} glamour url ssh)
endif()

# Read sha from glamour json data
string(JSON ${GLAMOUR_SHA} GET ${GLAMOUR_JSON_DATA} glamour sha)

# Read path from glamour json data
set(GLAMOUR_PATH_IDENTIFIER .glamour/${GLAMOUR_SHA})

if(IS_LOCAL)
  set(GLAMOUR_PATH ${CMAKE_BINARY_DIR}/.generated/${GLAMOUR_PATH_IDENTIFIER})
else()
  if(WIN32)
    set(GLAMOUR_BASE_PATH $ENV{HOMEDRIVE})
  else()
    set(GLAMOUR_BASE_PATH "$ENV{HOME}")
  endif()

  set(GLAMOUR_PATH ${GLAMOUR_BASE_PATH}/${GLAMOUR_PATH_IDENTIFIER})
endif()

# Clone glamour
clone_using_git(${GLAMOUR_URL} ${GLAMOUR_SHA} ${GLAMOUR_PATH})
