cmake_minimum_required(VERSION 3.5)
project(sheet6)

set(CMAKE_CXX_STANDARD 11)

find_package( OpenCV REQUIRED )

add_executable(sheet6 fusion.cpp main.cpp)
target_link_libraries(sheet6 ${OpenCV_LIBS})
