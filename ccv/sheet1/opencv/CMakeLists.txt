find_package( OpenCV REQUIRED )
add_executable(opencv opencv.cpp)
target_link_libraries( opencv ${OpenCV_LIBS} )
