#include "lab_pyramid.h"

int lab_pyramid::_number_of_layers = 0;
std::vector<cv::Mat> lab_pyramid::_cs_contrast_l = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_sc_contrast_l = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_cs_contrast_a = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_sc_contrast_a = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_cs_contrast_b = std::vector<cv::Mat>();
std::vector<cv::Mat> lab_pyramid::_sc_contrast_b = std::vector<cv::Mat>();

lab_pyramid::lab_pyramid(cv::String image_filename) {
  cv::Mat image_rgb = cv::imread(image_filename, cv::IMREAD_COLOR);
  cv::cvtColor(image_rgb, _inputImage_lab, cv::COLOR_RGB2Lab);
  cv::split(_inputImage_lab ,_imageChannels);
};

lab_pyramid::lab_pyramid(cv::Mat image) {
  cv::cvtColor(image, _inputImage_lab, cv::COLOR_RGB2Lab);
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
    cv::Mat center_layer_mat = center_l.get(layer);
    cv::Mat surround_layer_mat = surround_l.get(layer);
    cv::Mat dog_raw = center_layer_mat - surround_layer_mat;
    cv::Mat dog_final;
    cv::threshold(dog_raw, dog_final, 0, 1, cv::THRESH_TOZERO);
    _cs_contrast_l.push_back(dog_final);
    dog_raw = surround_layer_mat - center_layer_mat;
    cv::threshold(dog_raw, dog_final, 0, 1, cv::THRESH_TOZERO);
    _cs_contrast_l.push_back(dog_final);

    // A channel
    center_layer_mat = center_a.get(layer);
    surround_layer_mat = surround_a.get(layer);
    dog_raw = center_layer_mat - surround_layer_mat;
    cv::threshold(dog_raw, dog_final, 0, 1, cv::THRESH_TOZERO);
    _cs_contrast_a.push_back(dog_final);
    dog_raw = surround_layer_mat - center_layer_mat;
    cv::threshold(dog_raw, dog_final, 0, 1, cv::THRESH_TOZERO);
    _sc_contrast_a.push_back(dog_final);

    // B channel
    center_layer_mat = center_b.get(layer);
    surround_layer_mat = surround_b.get(layer);
    dog_raw = center_layer_mat - surround_layer_mat;
    cv::threshold(dog_raw, dog_final, 0, 1, cv::THRESH_TOZERO);
    _cs_contrast_b.push_back(dog_final);
    dog_raw = surround_layer_mat - center_layer_mat;
    cv::threshold(dog_raw, dog_final, 0, 1, cv::THRESH_TOZERO);
    _sc_contrast_b.push_back(dog_final);
  }
}

void lab_pyramid::visualize_dog() {
  for (unsigned long layer = 0; layer < _number_of_layers; layer++) {
    cv::namedWindow("CS L");
    cv::namedWindow("SC L");
    cv::namedWindow("CS A");
    cv::namedWindow("SC A");
    cv::namedWindow("CS B");
    cv::namedWindow("SC B");
    cv::imshow("CS L", _cs_contrast_l.at(layer));
    cv::imshow("SC L", _sc_contrast_l.at(layer));
    cv::imshow("CS A", _cs_contrast_a.at(layer));
    cv::imshow("SC A", _cs_contrast_a.at(layer));
    cv::imshow("CS B", _cs_contrast_b.at(layer));
    cv::imshow("SC B", _cs_contrast_b.at(layer));
    cv::waitKey(0);
  }
}
