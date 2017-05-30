#include "includes/oriented_pyramid.h"
#include "includes/fusion.h"

oriented_pyramid::oriented_pyramid(const laplacian_pyramid &pyramid, int num_orientations) {
  _gabor_filters = std::vector<cv::Mat>();
  _orientation_maps = std::vector<std::vector<cv::Mat>>();
  _feature_maps = std::vector<cv::Mat>();

  initialize_gabor_filters(num_orientations);
  unsigned long number_of_layers = pyramid.get_number_of_layers();
  for (unsigned long i = 0; i < num_orientations; i++) {
    std::vector<cv::Mat> orientation_vector = std::vector<cv::Mat>();
    for (int layer = 0; layer < number_of_layers; layer++) {
      cv::Mat filtered_image;
      cv::filter2D(pyramid.get(layer), filtered_image, -1, _gabor_filters.at(i), cv::Point(-1, -1), 0, cv::BORDER_CONSTANT);
      orientation_vector.push_back(filtered_image.clone());
    }
    _orientation_maps.push_back(orientation_vector);
  }

}

void oriented_pyramid::initialize_gabor_filters(float num_orientations) {
  cv::Size size = cv::Size(20, 20);
  double wavelength = 3;
  double standard_deviation = 18;

  double start_level = num_orientations / 2.0;
  for (double level = start_level; level >= 0; level--) {
    _gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, (level/num_orientations) * CV_PI, wavelength,
                                                1, 0, CV_32F));
  }

  double end_level = start_level;
  start_level = num_orientations - 1;

  for (double level = start_level; level > end_level; level--) {
    _gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, (level/num_orientations) * CV_PI, wavelength,
                                                1, 0, CV_32F));
  }
}

void oriented_pyramid::compute_feature_maps() {
  unsigned long num_orientations = _orientation_maps.size();
  for (unsigned long i = 0; i < num_orientations; i++) {
    cv::Mat feature_map = (cv::Mat &&) _orientation_maps.at(i).front();
    cv::Size original_size = feature_map.size();
    unsigned long num_layers = _orientation_maps.at(i).size();
    for (unsigned long layer = 1; layer < num_layers; layer++) {
      cv::Mat resized_image;
      cv::resize(_orientation_maps.at(i).at(layer), resized_image, original_size, 0, 0, cv::INTER_CUBIC);
      feature_map += resized_image;
    }
    _feature_maps.push_back(feature_map.clone());
  }
}

void oriented_pyramid::compute_conspicuity_map() {
  _C = max_fusion_generic(_feature_maps);
}

cv::Mat oriented_pyramid::get_conspicuity_map() {
  return _C;
}

cv::Mat oriented_pyramid::get_feature_map(unsigned long orientation) {
  return _feature_maps.at(orientation).clone();
}
