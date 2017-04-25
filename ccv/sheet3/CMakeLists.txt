cmake_minimum_required(VERSION 3.5)
project(sheet3)

set(CMAKE_CXX_STANDARD 11)

find_package( OpenCV REQUIRED )

add_executable(sheet3 main.cpp)
add_executable(sheet3-exercise1 exercise1.cpp)
add_executable(sheet3-exercise3 exercise3.cpp)
target_link_libraries(sheet3 ${OpenCV_LIBS})
target_link_libraries(sheet3-exercise1 ${OpenCV_LIBS})
target_link_libraries(sheet3-exercise3 ${OpenCV_LIBS})
