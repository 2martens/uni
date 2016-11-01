function [ distance ] = hist_dist_Manhattan( h1, h2 )
%HIST_DIST_MANHATTAN Calculates the Manhattan distance between 2 histograms
    distance = 0;
    s = size(h1);
    if s(1) > 1
        n = s(1);
    else
        n = s(2);
    end
    for i = 1:n
        distance = distance + abs(h1(i) - h2(i));
    end
end

