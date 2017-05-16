#include <opencv2/opencv.hpp>
#include "fusion.h"

int main(int argc, char **argv) {
  std::vector<cv::Mat> on_off(10);
  std::vector<cv::Mat> off_on(10);
  for (int i = 0; i < 10; ++i) {
    std::stringstream ss;
    ss << i;
    std::string i_as_str = ss.str();

    std::string off_on_filename = "../contrasts/off_on_L_" + i_as_str + ".png";
    off_on[i] = cv::imread(off_on_filename.c_str(), CV_LOAD_IMAGE_GRAYSCALE);
    off_on[i].convertTo(off_on[i], CV_32F);

    std::string on_off_filename = "../contrasts/on_off_L_" + i_as_str + ".png";
    on_off[i] = cv::imread(on_off_filename.c_str(), CV_LOAD_IMAGE_GRAYSCALE);
    on_off[i].convertTo(on_off[i], CV_32F);

    /*cv::namedWindow(off_on_filename.c_str(), CV_WINDOW_NORMAL);
    cv::imshow(off_on_filename.c_str(), off_on[i]);
    cv::namedWindow(on_off_filename.c_str(), CV_WINDOW_NORMAL);
    cv::imshow(on_off_filename.c_str(), on_off[i]);

    cv::waitKey(0);
    cv::destroyWindow(off_on_filename.c_str());
    cv::destroyWindow(on_off_filename.c_str());*/
  }
  cv::Mat feature_map_on_off = (cv::Mat &&) on_off.at(0);
  cv::Mat feature_map_off_on = (cv::Mat &&) off_on.at(0);
  cv::Size original_size_on_off = feature_map_on_off.size();
  cv::Size original_size_off_on = feature_map_off_on.size();
  for (unsigned long i = 1; i < 10; i++) {
    cv::Mat resized_image;
    cv::resize(on_off.at(i), resized_image, original_size_on_off, 0, 0, cv::INTER_CUBIC);
    feature_map_on_off += resized_image;
    cv::resize(off_on.at(i), resized_image, original_size_off_on, 0, 0, cv::INTER_CUBIC);
    feature_map_off_on += resized_image;
  }

  cv::Mat f_on_off_norm;
  cv::normalize(feature_map_on_off, f_on_off_norm, 0, 1, cv::NORM_MINMAX, -1);
  cv::namedWindow("F on off", CV_WINDOW_NORMAL);
  cv::imshow("F on off", f_on_off_norm);
  cv::Mat f_off_on_norm;
  cv::normalize(feature_map_off_on, f_off_on_norm, 0, 1, cv::NORM_MINMAX, -1);
  cv::namedWindow("F off on", CV_WINDOW_NORMAL);
  cv::imshow("F off on", f_off_on_norm);

  cv::waitKey(0);
  cv::destroyAllWindows();

  cv::Mat C_l_mean = mean_fusion(feature_map_on_off, feature_map_off_on);
  cv::Mat C_l_mean_norm;
  cv::normalize(C_l_mean, C_l_mean_norm, 0, 1, cv::NORM_MINMAX, -1);
  cv::namedWindow("C_l_mean", CV_WINDOW_NORMAL);
  cv::imshow("C_l_mean", C_l_mean_norm);
  cv::Mat C_l_max = max_fusion(feature_map_on_off, feature_map_off_on);
  cv::Mat C_l_max_norm;
  cv::normalize(C_l_max, C_l_max_norm, 0, 1, cv::NORM_MINMAX, -1);
  cv::namedWindow("C_l_max", CV_WINDOW_NORMAL);
  cv::imshow("C_l_max", C_l_max_norm);
  cv::waitKey(0);


  return 0;
}
