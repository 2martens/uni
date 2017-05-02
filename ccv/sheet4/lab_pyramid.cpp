#include "lab_pyramid.h"

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
