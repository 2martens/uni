#include <iostream>
#include <opencv2/opencv.hpp>
#include "lab_pyramid.h"

int main(int argc, char** argv) {
  if ( argc != 2 )
  {
    printf("usage: <Image_Path>\n");
    return -1;
  }

  cv::Mat image;
  image = cv::imread(argv[1], cv::ImreadModes::IMREAD_COLOR);

  int layers = 4;
  float sigma_center = 5;
  float sigma_surround = 9;

  // center
  lab_pyramid pyr_center = lab_pyramid(image);
  pyr_center.create_pyramids(sigma_center, layers);

  // surround
  lab_pyramid pyr_surround = lab_pyramid(image);
  pyr_surround.create_pyramids(sigma_surround, layers);

  lab_pyramid::compute_dog(pyr_center, pyr_surround, layers);
  lab_pyramid::visualize_dog();
  return 0;
}
