#ifndef SHEET6_FUSION_H
#define SHEET6_FUSION_H

cv::Mat mean_fusion_generic(const std::vector<cv::Mat> feature_maps);
cv::Mat max_fusion_generic(const std::vector<cv::Mat> feature_maps);

#endif //SHEET6_FUSION_H
