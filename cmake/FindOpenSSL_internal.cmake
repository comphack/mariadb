#   OPENSSL_FOUND - system has the OpenSSL library
#   OPENSSL_INCLUDE_DIR - the OpenSSL include directory
#   OPENSSL_LIBRARIES - The libraries needed to use OpenSSL
#   OPENSSL_VERSION - This is set to $major.$minor.$revision$path (eg. 0.9.8s)

SET(OPENSSL_FOUND True)
SET(OPENSSL_INCLUDE_DIR "${OPENSSL_ROOT_DIR}/include")

IF(WIN32)
    SET(OPENSSL_LIBRARIES ssleay32 libeay32 crypt32)
    SET(OPENSSL_SSL_LIBRARY ssleay32)
    SET(OPENSSL_CRYPTO_LIBRARY libeay32 crypt32)
ELSE()
    SET(OPENSSL_LIBRARIES ssl crypto)
    SET(OPENSSL_SSL_LIBRARY ssl)
    SET(OPENSSL_CRYPTO_LIBRARY crypto)
ENDIF()

IF(WIN32)
    ADD_LIBRARY(ssleay32 STATIC IMPORTED)
    SET_TARGET_PROPERTIES(ssleay32 PROPERTIES
        IMPORTED_LOCATION_RELEASE "${OPENSSL_ROOT_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}ssleay32${CMAKE_STATIC_LIBRARY_SUFFIX}"
        IMPORTED_LOCATION_RELWITHDEBINFO "${OPENSSL_ROOT_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}ssleay32_reldeb${CMAKE_STATIC_LIBRARY_SUFFIX}"
        IMPORTED_LOCATION_DEBUG "${OPENSSL_ROOT_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}ssleay32d${CMAKE_STATIC_LIBRARY_SUFFIX}")

    SET_TARGET_PROPERTIES(ssleay32 PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}")

    ADD_LIBRARY(libeay32 STATIC IMPORTED)
    SET_TARGET_PROPERTIES(libeay32 PROPERTIES
        IMPORTED_LOCATION_RELEASE "${OPENSSL_ROOT_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}libeay32${CMAKE_STATIC_LIBRARY_SUFFIX}"
        IMPORTED_LOCATION_RELWITHDEBINFO "${OPENSSL_ROOT_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}libeay32_reldeb${CMAKE_STATIC_LIBRARY_SUFFIX}"
        IMPORTED_LOCATION_DEBUG "${OPENSSL_ROOT_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}libeay32d${CMAKE_STATIC_LIBRARY_SUFFIX}")

    SET_TARGET_PROPERTIES(libeay32 PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}")
ELSE()
    ADD_LIBRARY(ssl STATIC IMPORTED)
    SET_TARGET_PROPERTIES(ssl PROPERTIES IMPORTED_LOCATION
        "${OPENSSL_ROOT_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}ssl${CMAKE_STATIC_LIBRARY_SUFFIX}")

    SET_TARGET_PROPERTIES(ssl PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}")

    ADD_LIBRARY(crypto STATIC IMPORTED)
    SET_TARGET_PROPERTIES(crypto PROPERTIES IMPORTED_LOCATION
        "${OPENSSL_ROOT_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}crypto${CMAKE_STATIC_LIBRARY_SUFFIX}")

    SET_TARGET_PROPERTIES(crypto PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}")
ENDIF()
