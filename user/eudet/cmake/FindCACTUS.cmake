if(WIN32)
  message(WARNING "CACTUS/uhal is NOT supported in Windows")
  return()
endif()

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  message(WARNING "CACTUS/uhal is NOT supported in MacOSX")
  return()
endif()


file(GLOB_RECURSE CACTUS_UHAL_HEADER_FOUND
  ${CMAKE_CURRENT_LIST_DIR}/../extern/*/uhal.hpp)

if(NOT CACTUS_UHAL_HEADER_FOUND)
  file(GLOB_RECURSE CACTUS_UHAL_HEADER_FOUND
    /opt/cactus/*/uhal.hpp)
endif()
  
if(NOT CACTUS_UHAL_HEADER_FOUND)
  message(WARNING "Check for CACTUS/uhal header uhal.hpp -- fail")
  return()
endif()

message(STATUS "Check for CACTUS/uhal header uhal.hpp: ${CACTUS_UHAL_HEADER_FOUND} -- ok")

# using the 1st found file uhal.hpp.  
list(GET CACTUS_UHAL_HEADER_FOUND 0 CACTUS_UHAL_HEADER_FILE)
get_filename_component(CACTUS_UHAL_HEADER_FILE ${CACTUS_UHAL_HEADER_FILE} ABSOLUTE)

# defining absulote path of uhal.hpp
get_filename_component(CACTUS_UHAL_UHAL_INCLUDE_DIR ${CACTUS_UHAL_HEADER_FILE} DIRECTORY)
get_filename_component(CACTUS_UHAL_INCLUDE_DIR ${CACTUS_UHAL_UHAL_INCLUDE_DIR} DIRECTORY)
get_filename_component(CACTUS_INCLUDE_DIR ${CACTUS_UHAL_INCLUDE_DIR} DIRECTORY)
set(CACTUS_INCLUDE_DIRS ${CACTUS_INCLUDE_DIR}
  ${CACTUS_UHAL_INCLUDE_DIR} ${CACTUS_UHAL_UHAL_INCLUDE_DIR})
message(STATUS "Set CACTUS_INCLUDE_DIRS to : ${CACTUS_INCLUDE_DIRS}")
get_filename_component(CACTUS_LIBRARY_DIR ${CACTUS_INCLUDE_DIR}/../lib ABSOLUTE)
message(STATUS "Set CACTUS_LIBRARY_DIR to : ${CACTUS_LIBRARY_DIR}")

find_library(CACTUS_UHAL_UHAL_LIBRARY cactus_uhal_uhal
  HINTS ${CACTUS_LIBRARY_DIR})
if(CACTUS_UHAL_UHAL_LIBRARY)
  list(APPEND CACTUS_LIBRARIES ${CACTUS_UHAL_UHAL_LIBRARY})
endif()
unset(CACTUS_UHAL_UHAL_LIBRARY CACHE)

find_library(CACTUS_UHAL_LOG_LIBRARY cactus_uhal_log
  HINTS ${CACTUS_LIBRARY_DIR})
if(CACTUS_UHAL_LOG_LIBRARY)
  list(APPEND CACTUS_LIBRARIES ${CACTUS_UHAL_LOG_LIBRARY})
endif()
unset(CACTUS_UHAL_LOG_LIBRARY CACHE)

find_library(CACTUS_UHAL_GRAMMARS_LIBRARY cactus_uhal_grammars
  HINTS ${CACTUS_LIBRARY_DIR})
if(CACTUS_UHAL_GRAMMARS_LIBRARY)
  list(APPEND CACTUS_LIBRARIES ${CACTUS_UHAL_GRAMMARS_LIBRARY})
endif()

find_library(CACTUS_BOOST_SYSTEM_LIBRARY boost_system
  HINTS ${CACTUS_LIBRARY_DIR})
if(CACTUS_BOOST_SYSTEM_LIBRARY)
  list(APPEND CACTUS_LIBRARIES ${CACTUS_BOOST_SYSTEM_LIBRARY})
endif()
unset(CACTUS_BOOST_SYSTEM_LIBRARY CACHE)

find_library(CACTUS_BOOST_THREAD_LIBRARY boost_thread
  HINTS ${CACTUS_LIBRARY_DIR})
if(CACTUS_BOOST_THREAD_LIBRARY)
  list(APPEND CACTUS_LIBRARIES ${CACTUS_BOOST_THREAD_LIBRARY})
endif()
unset(CACTUS_BOOST_THREAD_LIBRARY CACHE)


message(STATUS "Set CACTUS_LIBRARIES to : ${CACTUS_LIBRARIES}")

find_package_handle_standard_args(CACTUS DEFAULT_MSG
  CACTUS_INCLUDE_DIR CACTUS_LIBRARY_DIR CACTUS_LIBRARIES)
