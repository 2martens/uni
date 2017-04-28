#include "lab_pyramid.h"

int main(int argc, char** argv ) {
  if ( argc != 2 )
  {
    printf("usage: <Image_Path>\n");
    return -1;
  }

  lab_pyramid pyramid = lab_pyramid(argv[1]);
  const int number_of_layers = 5;
  pyramid.create_pyramids(number_of_layers);
  gauss_pyramid l_pyr = pyramid.get_pyramid(lab_pyramid::COLOR_L);
  gauss_pyramid a_pyr = pyramid.get_pyramid(lab_pyramid::COLOR_A);
  gauss_pyramid b_pyr = pyramid.get_pyramid(lab_pyramid::COLOR_B);

  for (int i = 0; i < number_of_layers; i++)
  {
    cv::imshow("Channel: L, Layer:" + std::to_string(i), l_pyr.get(i));
    cv::waitKey(0);
  }

  for (int i = 0; i < number_of_layers; i++)
  {
    cv::imshow("Channel: A, Layer:" + std::to_string(i), a_pyr.get(i));
    cv::waitKey(0);
  }

  for (int i = 0; i < number_of_layers; i++)
  {
    cv::imshow("Channel: B, Layer:" + std::to_string(i), b_pyr.get(i));
    cv::waitKey(0);
  }
  return 0;
}
