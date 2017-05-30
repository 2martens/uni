#include "includes/lab_pyramid.h"
#include "includes/fusion.h"

// number of layers
int lab_pyramid::_number_of_layers = 0;
// contrast maps
std::vector<cv::Mat> lab_pyramid::_cs_contrast_l = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_sc_contrast_l = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_cs_contrast_a = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_sc_contrast_a = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_cs_contrast_b = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_sc_contrast_b = std::vector<cv::Mat>();
// feature maps
cv::Mat lab_pyramid::_cs_F_l;
cv::Mat lab_pyramid::_sc_F_l;
cv::Mat lab_pyramid::_cs_F_a;
cv::Mat lab_pyramid::_sc_F_a;
cv::Mat lab_pyramid::_cs_F_b;
cv::Mat lab_pyramid::_sc_F_b;
// conspicuity maps
cv::Mat lab_pyramid::_C_l;
cv::Mat lab_pyramid::_C_a;
cv::Mat lab_pyramid::_C_b;

lab_pyramid::lab_pyramid(cv::String image_filename) {
  cv::Mat image_rgb = cv::imread(image_filename, cv::IMREAD_COLOR);
  cv::cvtColor(image_rgb, _inputImage_lab, cv::COLOR_BGR2Lab);
  cv::split(_inputImage_lab ,_imageChannels);
};

lab_pyramid::lab_pyramid(cv::Mat image) {
  cv::cvtColor(image, _inputImage_lab, cv::COLOR_BGR2Lab);
  _inputImage_lab.convertTo(_inputImage_float, CV_32F);
  cv::split(_inputImage_float, _imageChannels);
}

void lab_pyramid::create_pyramids(float sigma, int number_of_layers)
{
  _pyramids[COLOR_L] = gauss_pyramid(_imageChannels[COLOR_L], sigma, number_of_layers);
  _pyramids[COLOR_A] = gauss_pyramid(_imageChannels[COLOR_A], sigma, number_of_layers);
  _pyramids[COLOR_B] = gauss_pyramid(_imageChannels[COLOR_B], sigma, number_of_layers);
}

gauss_pyramid lab_pyramid::get_pyramid(int channel)
{
  switch (channel)
  {
    case COLOR_L:
      return _pyramids[COLOR_L];
    case COLOR_A:
      return _pyramids[COLOR_A];
    case COLOR_B:
      return _pyramids[COLOR_B];
    default:
      throw std::invalid_argument( "received invalid channel value, use COLOR_L, COLOR_A or COLOR_B" );
  }
}

void lab_pyramid::compute_dog(lab_pyramid center, lab_pyramid surround, int number_of_layers) {
  _number_of_layers = number_of_layers;

  // L channel
  gauss_pyramid center_l = center.get_pyramid(COLOR_L);
  gauss_pyramid surround_l = surround.get_pyramid(COLOR_L);

  // A channel
  gauss_pyramid center_a = center.get_pyramid(COLOR_A);
  gauss_pyramid surround_a = surround.get_pyramid(COLOR_A);

  // A channel
  gauss_pyramid center_b = center.get_pyramid(COLOR_B);
  gauss_pyramid surround_b = surround.get_pyramid(COLOR_B);

  for (int layer = 0; layer < number_of_layers; layer++) {
    // L channel
    cv::Mat center_layer_mat_L = center_l.get(layer);
    cv::Mat surround_layer_mat_L = surround_l.get(layer);
    cv::Mat dog_raw_cs_L = center_layer_mat_L - surround_layer_mat_L;
    cv::Mat dog_final_cs_L;
    cv::Mat dog_final_sc_L;
    cv::threshold(dog_raw_cs_L, dog_final_cs_L, 0, 1, cv::THRESH_TOZERO);
    _cs_contrast_l.push_back(dog_final_cs_L.clone());
    cv::Mat dog_raw_sc_L = surround_layer_mat_L - center_layer_mat_L;
    cv::threshold(dog_raw_sc_L, dog_final_sc_L, 0, 1, cv::THRESH_TOZERO);
    _sc_contrast_l.push_back(dog_final_sc_L.clone());

    // A channel
    cv::Mat center_layer_mat_a = center_a.get(layer);
    cv::Mat surround_layer_mat_a = surround_a.get(layer);
    cv::Mat dog_raw_cs_a = center_layer_mat_a - surround_layer_mat_a;
    cv::Mat dog_final_cs_a;
    cv::Mat dog_final_sc_a;
    cv::threshold(dog_raw_cs_a, dog_final_cs_a, 0, 1, cv::THRESH_TOZERO);
    _cs_contrast_a.push_back(dog_final_cs_a.clone());
    cv::Mat dog_raw_sc_a = surround_layer_mat_a - center_layer_mat_a;
    cv::threshold(dog_raw_sc_a, dog_final_sc_a, 0, 1, cv::THRESH_TOZERO);
    _sc_contrast_a.push_back(dog_final_sc_a.clone());

    // B channel
    cv::Mat center_layer_mat_b = center_b.get(layer);
    cv::Mat surround_layer_mat_b = surround_b.get(layer);
    cv::Mat dog_raw_cs_b = center_layer_mat_b - surround_layer_mat_b;
    cv::Mat dog_final_cs_b;
    cv::Mat dog_final_sc_b;
    cv::threshold(dog_raw_cs_b, dog_final_cs_b, 0, 1, cv::THRESH_TOZERO);
    _cs_contrast_b.push_back(dog_final_cs_b.clone());
    cv::Mat dog_raw_sc_b = surround_layer_mat_b - center_layer_mat_b;
    cv::threshold(dog_raw_sc_b, dog_final_sc_b, 0, 1, cv::THRESH_TOZERO);
    _sc_contrast_b.push_back(dog_final_sc_b.clone());
  }
}

void lab_pyramid::compute_feature_maps() {
  _cs_F_l = across_scale_addition(_cs_contrast_l);
  _sc_F_l = across_scale_addition(_sc_contrast_l);
  _cs_F_a = across_scale_addition(_cs_contrast_a);
  _sc_F_a = across_scale_addition(_sc_contrast_a);
  _cs_F_b = across_scale_addition(_cs_contrast_b);
  _sc_F_b = across_scale_addition(_sc_contrast_b);
}

void lab_pyramid::compute_conspicuity_maps() {
  _C_l = max_fusion(_cs_F_l, _sc_F_l);
  _C_a = max_fusion(_cs_F_a, _sc_F_a);
  _C_b = max_fusion(_cs_F_b, _sc_F_b);
}

cv::Mat lab_pyramid::get_conspicuity_map(int channel) {
  switch (channel)
  {
    case COLOR_L:
      return _C_l;
    case COLOR_A:
      return _C_a;
    case COLOR_B:
      return _C_b;
    default:
      throw std::invalid_argument( "received invalid channel value, use COLOR_L, COLOR_A or COLOR_B" );
  }
}

cv::Mat lab_pyramid::across_scale_addition(const std::vector<cv::Mat> &scale_images) {
  cv::Mat result = scale_images.front();
  cv::Size original_size = scale_images.front().size();
  for (unsigned long i = 1; i < scale_images.size(); i++) {
    cv::Mat resized_image;
    cv::resize(scale_images.at(i), resized_image, original_size, 0, 0, cv::INTER_CUBIC);
    result += resized_image;
  }
  return result;
}

void lab_pyramid::visualize_dog() {
  for (unsigned long layer = 0; layer < _number_of_layers; layer++) {
    cv::namedWindow("CS L");
    cv::imshow("CS L", _cs_contrast_l.at(layer));
    cv::namedWindow("SC L");
    cv::imshow("SC L", _sc_contrast_l.at(layer));
    cv::namedWindow("CS A");
    cv::imshow("CS A", _cs_contrast_a.at(layer));
    cv::namedWindow("SC A");
    cv::imshow("SC A", _cs_contrast_a.at(layer));
    cv::namedWindow("CS B");
    cv::imshow("CS B", _cs_contrast_b.at(layer));
    cv::namedWindow("SC B");
    cv::imshow("SC B", _cs_contrast_b.at(layer));
    cv::waitKey(0);
  }
}

void lab_pyramid::visualize_feature_maps() {
  cv::namedWindow("CS F L");
  cv::imshow("CS F L", _cs_F_l);
  cv::namedWindow("CS F L");
  cv::imshow("SC F L", _sc_F_l);
  cv::namedWindow("CS F A");
  cv::imshow("CS F A", _cs_F_a);
  cv::namedWindow("SC F A");
  cv::imshow("SC F A", _sc_F_a);
  cv::namedWindow("CS F B");
  cv::imshow("CS F B", _cs_F_b);
  cv::namedWindow("CS F B");
  cv::imshow("SC F B", _sc_F_b);
  cv::waitKey(0);
}
