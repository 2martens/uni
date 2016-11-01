function [ distance ] = hist_dist_Euclidean( h1, h2 )
%HIST_DIST_EUCLIDEAN Calculates euclidean distance between histograms

    sum_of_differences = 0;
    s = size(h1);
    if s(1) > 1
        n = s(1);
    else
        n = s(2);
    end
    for i = 1:n
        sum_of_differences = sum_of_differences + (h1(i) - h2(i))^2; 
    end

    distance = sqrt(sum_of_differences);

end

