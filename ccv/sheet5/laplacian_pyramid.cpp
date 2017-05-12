#include "laplacian_pyramid.h"

laplacian_pyramid::laplacian_pyramid(const gauss_pyramid &pyramid, float sigma) {
  _layers = std::vector<cv::Mat>();
  unsigned long number_of_layers = pyramid.get_number_of_layers();
  for (int i = 0; i < number_of_layers; i++) {
    cv::Mat blurred;
    cv::GaussianBlur(pyramid.get(i), blurred, cv::Size(), sigma, sigma, cv::BORDER_CONSTANT);
    _layers.push_back(pyramid.get(i) - blurred);
  }
}
