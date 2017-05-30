#ifndef SHEET6_FUSION_H
#define SHEET6_FUSION_H

cv::Mat mean_fusion(cv::Mat f_on_off, cv::Mat f_off_on);
cv::Mat max_fusion(cv::Mat f_on_off, cv::Mat f_off_on);
cv::Mat mean_fusion_saliency(cv::Mat C_l, cv::Mat C_a, cv::Mat C_b);
cv::Mat max_fusion_saliency(cv::Mat C_l, cv::Mat C_a, cv::Mat C_b);

#endif //SHEET6_FUSION_H
