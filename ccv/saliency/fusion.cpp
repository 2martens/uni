#include <opencv2/opencv.hpp>
#include "includes/fusion.h"

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
 * @return conspicuity map
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

/**
 * Computes the saliency map using mean fusion.
 *
 * @param C_l conspicuity map for L channel
 * @param C_a conspicuity map for A channel
 * @param C_b conspicuity map for B channel
 * @return saliency map
 */
cv::Mat mean_fusion_saliency(cv::Mat C_l, cv::Mat C_a, cv::Mat C_b) {
  cv::Mat S = (1/3.0) * (C_l + C_a + C_b);
  double max_C_l;
  double max_C_a;
  double max_C_b;
  cv::minMaxLoc(C_l, nullptr, &max_C_l);
  cv::minMaxLoc(C_a, nullptr, &max_C_a);
  cv::minMaxLoc(C_b, nullptr, &max_C_b);
  double max = max_C_l >= max_C_a ? (max_C_l >= max_C_b ? max_C_l : max_C_b) : (max_C_a >= max_C_b ? max_C_a : max_C_b);
  cv::normalize(S, S, 0, max, cv::NORM_MINMAX, -1);

  return S;
}

/**
 * Computes the saliency map using max fusion.
 *
 * @param C_l conspicuity map for L channel
 * @param C_a conspicuity map for A channel
 * @param C_b conspicuity map for B channel
 * @return saliency map
 */
cv::Mat max_fusion_saliency(cv::Mat C_l, cv::Mat C_a, cv::Mat C_b) {
  cv::Mat S = cv::max(C_l, C_a);
  S = cv::max(S, C_b);

  double max_C_l;
  double max_C_a;
  double max_C_b;
  cv::minMaxLoc(C_l, nullptr, &max_C_l);
  cv::minMaxLoc(C_a, nullptr, &max_C_a);
  cv::minMaxLoc(C_b, nullptr, &max_C_b);
  double max = max_C_l >= max_C_a ? (max_C_l >= max_C_b ? max_C_l : max_C_b) : (max_C_a >= max_C_b ? max_C_a : max_C_b);
  cv::normalize(S, S, 0, max, cv::NORM_MINMAX, -1);

  return S;
}
