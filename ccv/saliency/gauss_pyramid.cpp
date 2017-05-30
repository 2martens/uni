#include "includes/gauss_pyramid.h"

gauss_pyramid::gauss_pyramid() {}

gauss_pyramid::gauss_pyramid(const cv::Mat img, float sigma, int number_of_layers)
{
  cv::Mat blurredImage;
  cv::Mat resizedImage = img.clone();
  for (int i = 0; i < number_of_layers; i++)
  {
    cv::GaussianBlur(resizedImage, blurredImage, cv::Size(0, 0), sigma, sigma, cv::BORDER_REPLICATE);
    _layers.push_back(blurredImage.clone());
    cv::resize(blurredImage, resizedImage, cv::Size(), 0.5, 0.5, cv::INTER_NEAREST);
  }
}

cv::Mat gauss_pyramid::get(int layer) const
{
  return _layers.at((unsigned long) layer);
}

cv::Mat gauss_pyramid::get(int layer)
{
  return _layers.at((unsigned long) layer);
}

unsigned long gauss_pyramid::get_number_of_layers() const
{
  return _layers.size();
}

unsigned long gauss_pyramid::get_number_of_layers()
{
  return _layers.size();
}
