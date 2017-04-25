#include <opencv2/opencv.hpp>

int main(int argc, char** argv ) {
  if ( argc != 2 )
  {
    printf("usage: <Image_Path>\n");
    return -1;
  }

  cv::Mat image;
  image = cv::imread(argv[1], cv::ImreadModes::IMREAD_COLOR);
  cv::Mat image_gray;
  cv::cvtColor(image, image_gray, cv::COLOR_BGR2GRAY);
  cv::Mat image_float;
  image_gray.convertTo(image_float, CV_32F);

  cv::Mat G_1;
  cv::Mat G_2;
  cv::GaussianBlur(image_float, G_1, cv::Size(3, 3), 3, 3, cv::BORDER_CONSTANT);
  cv::GaussianBlur(image_float, G_2, cv::Size(3, 3), 11, 11, cv::BORDER_CONSTANT);
  cv::Mat image_filtered = G_1 - G_2;

  cv::imshow("Filtered (3 - 11)", image_filtered);
  cv::waitKey(0);

  cv::GaussianBlur(image_float, G_1, cv::Size(3, 3), 3, 3, cv::BORDER_CONSTANT);
  cv::GaussianBlur(image_float, G_2, cv::Size(3, 3), 7, 7, cv::BORDER_CONSTANT);
  image_filtered = G_1 - G_2;

  cv::imshow("Filtered (3 - 7)", image_filtered);
  cv::waitKey(0);

  cv::GaussianBlur(image_float, G_1, cv::Size(3, 3), 5, 5, cv::BORDER_CONSTANT);
  cv::GaussianBlur(image_float, G_2, cv::Size(3, 3), 7, 7, cv::BORDER_CONSTANT);
  image_filtered = G_1 - G_2;

  cv::imshow("Filtered (5 - 7)", image_filtered);
  cv::waitKey(0);

  cv::GaussianBlur(image_float, G_1, cv::Size(3, 3), 11, 11, cv::BORDER_CONSTANT);
  cv::GaussianBlur(image_float, G_2, cv::Size(3, 3), 3, 3, cv::BORDER_CONSTANT);
  image_filtered = G_1 - G_2;
  image_float.convertTo(image_gray, CV_8U);

  cv::imshow("Filtered (11 - 3)", image_filtered);
  cv::waitKey(0);

  cv::GaussianBlur(image_float, G_1, cv::Size(3, 3), 9, 9, cv::BORDER_CONSTANT);
  cv::GaussianBlur(image_float, G_2, cv::Size(3, 3), 5, 5, cv::BORDER_CONSTANT);
  image_filtered = G_1 - G_2;

  cv::imshow("Filtered (9 - 5)", image_filtered);
  cv::waitKey(0);
}

