SET(_POSSIBLE_LUA_INCLUDE include include/lua)
SET(_POSSIBLE_LUA_LIBRARY lua)

SET(_POSSIBLE_SUFFIXES "51" "5.1" "-5.1")

FOREACH(_SUFFIX ${_POSSIBLE_SUFFIXES})
  LIST(APPEND _POSSIBLE_LUA_INCLUDE "include/lua${_SUFFIX}")
  LIST(APPEND _POSSIBLE_LUA_LIBRARY "lua${_SUFFIX}")
ENDFOREACH(_SUFFIX)

FIND_PATH(LUA_INCLUDE_DIR lua.h
  HINTS
  $ENV{LUA_DIR}
  PATH_SUFFIXES ${_POSSIBLE_LUA_INCLUDE}
  PATHS
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw
  /opt/local
  /opt/csw
  /opt
)

FIND_LIBRARY(LUA_LIBRARY
  NAMES ${_POSSIBLE_LUA_LIBRARY}
  HINTS
  $ENV{LUA_DIR}  
  PATH_SUFFIXES lib64 lib
  PATHS
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw
  /opt/local
  /opt/csw
  /opt
)

if(LUA_LIBRARY)
  IF(UNIX AND NOT APPLE)
    FIND_LIBRARY(LUA_MATH_LIBRARY m)
    SET(LUA_LIBRARIES "${LUA_LIBRARY};${LUA_MATH_LIBRARY}" CACHE STRING "Lua Libraries")
  ELSE(UNIX AND NOT APPLE)
    SET(LUA_LIBRARIES "${LUA_LIBRARY}" CACHE STRING "Lua Libraries")
  ENDIF(UNIX AND NOT APPLE)
ENDIF()

INCLUDE(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(Lua
                                  REQUIRED_VARS LUA_LIBRARIES LUA_INCLUDE_DIR)

MARK_AS_ADVANCED(LUA_INCLUDE_DIR LUA_LIBRARIES LUA_LIBRARY LUA_MATH_LIBRARY)
