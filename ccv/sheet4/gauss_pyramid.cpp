#include "gauss_pyramid.h"

gauss_pyramid::gauss_pyramid() {}

gauss_pyramid::gauss_pyramid(cv::Mat img, float sigma, int number_of_layers)
{
  _layers.push_back(img);
  cv::Mat blurredImage;
  cv::Mat resizedImage = img;
  for (int i = 1; i < number_of_layers; i++)
  {
    cv::GaussianBlur(resizedImage, blurredImage, cv::Size(0, 0), sigma, sigma, cv::BORDER_REPLICATE);
    cv::resize(blurredImage, resizedImage, cv::Size(), 0.5, 0.5, cv::INTER_NEAREST);
    _layers.push_back(resizedImage);
  }
}

cv::Mat gauss_pyramid::get(int layer)
{
  return _layers.at((unsigned long) layer);
}

unsigned long gauss_pyramid::get_number_of_layers()
{
  return _layers.size();
}
