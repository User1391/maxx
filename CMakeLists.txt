cmake_minimum_required(VERSION 3.15)
project(maxx)

set(CMAKE_CXX_STANDARD 17)

include_directories(
    ${CMAKE_SOURCE_DIR}/generated
    /usr/include/antlr4-runtime
)

file(GLOB_RECURSE SOURCES
    src/*.cpp
    generated/*.cpp
)

add_executable(maxx ${SOURCES})

target_link_libraries(maxx
    /usr/lib/libantlr4-runtime.a
)

