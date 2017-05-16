#include <opencv2/opencv.hpp>
#include "fusion.h"

/**
 * Returns the mean fusion of two feature maps.
 *
 * @param f_on_off feature map on off
 * @param f_off_on feature map off on
 * @return conspicuity map
 */
cv::Mat mean_fusion(cv::Mat f_on_off, cv::Mat f_off_on) {
  cv::Mat C_l = 0.5 * (f_on_off + f_off_on);
  double max_on_off;
  double max_off_on;
  cv::minMaxLoc(f_on_off, nullptr, &max_on_off);
  cv::minMaxLoc(f_off_on, nullptr, &max_off_on);
  double max = max_on_off >= max_off_on ? max_on_off : max_off_on;
  cv::normalize(C_l, C_l, 0, max, cv::NORM_MINMAX, -1);

  return C_l.clone();
}

/**
 * Returns the max fusion of two feature maps.
 *
 * @param f_on_off feature map on off
 * @param f_off_on feature map off on
 * @return constpicuity map
 */
cv::Mat max_fusion(cv::Mat f_on_off, cv::Mat f_off_on) {
  cv::Mat C_l = cv::max(f_on_off, f_off_on);
  double max_on_off;
  double max_off_on;
  cv::minMaxLoc(f_on_off, nullptr, &max_on_off);
  cv::minMaxLoc(f_off_on, nullptr, &max_off_on);
  double max = max_on_off >= max_off_on ? max_on_off : max_off_on;
  cv::normalize(C_l, C_l, 0, max, cv::NORM_MINMAX, -1);

  return C_l.clone();
}
