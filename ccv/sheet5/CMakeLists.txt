cmake_minimum_required(VERSION 3.5)
project(sheet5)

set(CMAKE_CXX_STANDARD 11)

find_package( OpenCV REQUIRED )

add_executable(sheet5 gauss_pyramid.cpp laplacian_pyramid.cpp oriented_pyramid.cpp main.cpp)
target_link_libraries(sheet5 ${OpenCV_LIBS})
