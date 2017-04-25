#include <opencv2/opencv.hpp>

int main(int argc, char** argv ) {
  if ( argc != 2 )
  {
    printf("usage: main.out <Image_Path>\n");
    return -1;
  }

  // exercise 2
  cv::Mat image;
  image = cv::imread(argv[1], cv::ImreadModes::IMREAD_COLOR);
  int kmax = 50;
  cv::Mat Matrix_convoluted;
  for (int k = 3; k < kmax; k+=2) {
    cv::GaussianBlur(image, Matrix_convoluted, cv::Size(k, k), 0, 0, cv::BORDER_CONSTANT);
    std::string imageName = "Kernel (";
    imageName = imageName + std::to_string(k) + ", " + std::to_string(k) + ")";
    cv::imshow(imageName, Matrix_convoluted);
    cv::waitKey(500);
  }

  return 0;
}
