cmake_minimum_required(VERSION 3.5)
project(sheet4)

set(CMAKE_CXX_STANDARD 11)

find_package( OpenCV REQUIRED )

add_executable(sheet4 gauss_pyramid.cpp lab_pyramid.cpp main.cpp)
target_link_libraries(sheet4 ${OpenCV_LIBS})
