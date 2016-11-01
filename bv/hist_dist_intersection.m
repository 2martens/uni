function [ intersection ] = hist_dist_intersection( h1, h2 )
%HIST_DIST_INTERSECTION Calculates intersection between 2 histograms

    intersection = 0;
    s = size(h1);
    if s(1) > 1
        n = s(1);
    else
        n = s(2);
    end
    for i = 1:n
        intersection = intersection + min(h1(i), h2(i));
    end
end

