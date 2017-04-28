#include "gauss_pyramid.h"

gauss_pyramid::gauss_pyramid() {}

gauss_pyramid::gauss_pyramid(cv::Mat img, int number_of_layers)
{
  _layers.push_back(img);
  cv::Mat blurredImage;
  cv::Mat resizedImage = img;
  for (int i = 1; i < number_of_layers; i++)
  {
    cv::GaussianBlur(resizedImage, blurredImage, cv::Size(5, 5), 0, 0, cv::BORDER_CONSTANT);
    cv::resize(blurredImage, resizedImage, cv::Size(), 0.5, 0.5, cv::INTER_NEAREST);
    _layers.push_back(resizedImage);
  }
}

cv::Mat gauss_pyramid::get(int layer)
{
  return _layers.at((unsigned long) layer);
}
