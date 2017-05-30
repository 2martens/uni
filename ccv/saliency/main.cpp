#include <opencv2/opencv.hpp>

#include "includes/lab_pyramid.h"
#include "includes/fusion.h"
#include "includes/laplacian_pyramid.h"
#include "includes/oriented_pyramid.h"

/**
 * Entry point of program
 * @param argc number of arguments
 * @param argv CLI arguments, 0: name of program, 1: input file name, 2: output file name, 3: flag for usage of orientation
 * @return status code (0: everything OK, -1: not right amount of arguments)
 */
int main(int argc, char** argv) {
  if (argc != 4) {
    printf("usage: <input file name> <output file name> <use orientation>\n");
    return -1;
  }

  // read image
  cv::Mat image = cv::imread(argv[1], cv::ImreadModes::IMREAD_COLOR);
  bool use_orientation = (strcmp(argv[3], "1") == 0);

  // tweakable factors
  int layers = 4;
  float sigma_center = 3;
  float sigma_surround = 7;
  float sigma_laplacian = 4;

  int number_orientations = 4;
  int gabor_size = 7;
  double wavelength = 5;
  double standard_deviation = 5;

  // create LAB pyramids
  lab_pyramid lab_pyr_center = lab_pyramid(image);
  lab_pyr_center.create_pyramids(sigma_center, layers);
  lab_pyramid lab_pyr_surround = lab_pyramid(image);
  lab_pyr_surround.create_pyramids(sigma_surround, layers);
  // create laplacian pyramid
  gauss_pyramid c_pyr_L = lab_pyr_center.get_pyramid(lab_pyramid::COLOR_L);
  laplacian_pyramid laplacian_pyr = laplacian_pyramid(c_pyr_L, sigma_laplacian);
  // create orientation pyramid
  oriented_pyramid oriented_pyr = oriented_pyramid(laplacian_pyr, number_orientations, gabor_size, wavelength,
                                                   standard_deviation);

  // create contrast maps
  lab_pyramid::compute_dog(lab_pyr_center, lab_pyr_surround, layers);
  // create feature maps
  lab_pyramid::compute_feature_maps();
  if (use_orientation) {
    oriented_pyr.compute_feature_maps();
  }
  // create conspicuity maps
  lab_pyramid::compute_conspicuity_maps();
  if (use_orientation) {
    oriented_pyr.compute_conspicuity_map();
  }
  // get conspicuity maps
  std::vector<cv::Mat> conspicuity_maps = std::vector<cv::Mat>();
  conspicuity_maps.push_back(lab_pyramid::get_conspicuity_map(lab_pyramid::COLOR_L));
  conspicuity_maps.push_back(lab_pyramid::get_conspicuity_map(lab_pyramid::COLOR_A));
  conspicuity_maps.push_back(lab_pyramid::get_conspicuity_map(lab_pyramid::COLOR_B));
  if (use_orientation) {
    conspicuity_maps.push_back(oriented_pyr.get_conspicuity_map());
  }
  // get saliency map
  cv::Mat saliency = max_fusion_generic(conspicuity_maps);

  // convert saliency map to correct output format
  cv::Mat output_image;
  saliency.convertTo(output_image, CV_8UC1);

  // write output
  cv::imwrite(argv[2], output_image);

  return 0;
}
