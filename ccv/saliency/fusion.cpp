#include <opencv2/opencv.hpp>
#include "includes/fusion.h"

/**
 * Returns the mean fusion.
 *
 * @param feature_maps vector of feature maps
 * @return conspicuity map
 */
cv::Mat mean_fusion_generic(const std::vector<cv::Mat> feature_maps) {
  unsigned long number_of_features = feature_maps.size();
  cv::Mat sum_of_features;
  double max = -1;
  bool first_run = true;
  for (auto& f : feature_maps) {
    if (first_run) {
      sum_of_features = f.clone();
      first_run = false;
    }
    else {
      sum_of_features = sum_of_features + f;
    }
    double max_value;
    cv::minMaxLoc(f, nullptr, &max_value);
    if (max_value >= max) {
      max = max_value;
    }
  }
  cv::Mat C = 1./number_of_features * sum_of_features;
  cv::normalize(C, C, 0, max, cv::NORM_MINMAX, -1);

  return C.clone();
}

/**
 * Returns the max fusion.
 *
 * @param feature_maps vector of feature maps
 * @return conspicuity map
 */
cv::Mat max_fusion_generic(const std::vector<cv::Mat> feature_maps) {
  cv::Mat C;
  bool first_value = true;

  double max = -1;
  for (auto& f : feature_maps) {
    double max_value;
    cv::minMaxLoc(f, nullptr, &max_value);
    if (max_value >= max) {
      max = max_value;
    }

    if (first_value) {
      C = f.clone();
      first_value = false;
    }
    else {
      C = cv::max(C, f);
    }
  }
  cv::normalize(C, C, 0, max, cv::NORM_MINMAX, -1);

  return C.clone();
}
