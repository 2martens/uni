#include "includes/laplacian_pyramid.h"

laplacian_pyramid::laplacian_pyramid(const gauss_pyramid &pyramid, float sigma) {
  _layers = std::vector<cv::Mat>();
  unsigned long number_of_layers = pyramid.get_number_of_layers();
  for (int i = 0; i < number_of_layers; i++) {
    cv::Mat blurred;
    cv::GaussianBlur(pyramid.get(i), blurred, cv::Size(), sigma, sigma, cv::BORDER_CONSTANT);
    cv::Mat laplacian = pyramid.get(i) - blurred;
    _layers.push_back(laplacian.clone());
  }
}

cv::Mat laplacian_pyramid::get(int layer) const {
  return _layers.at((unsigned long) layer);
}

unsigned long laplacian_pyramid::get_number_of_layers() const {
  return _layers.size();
}
