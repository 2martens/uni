cmake_minimum_required(VERSION 3.5)
project(sheet2)

set(CMAKE_CXX_STANDARD 11)

find_package( OpenCV REQUIRED )

add_executable(sheet2 main.cpp)
target_link_libraries(sheet2 ${OpenCV_LIBS})
