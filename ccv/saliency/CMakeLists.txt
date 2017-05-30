cmake_minimum_required(VERSION 3.5)
project(saliency)

set(CMAKE_CXX_STANDARD 11)

find_package( OpenCV REQUIRED )

add_executable(saliency fusion.cpp gauss_pyramid.cpp lab_pyramid.cpp main.cpp)
target_link_libraries(saliency ${OpenCV_LIBS})
