function [v] = variance( image )
%VARIANCE Calculates the variance of an image

    if isinteger(image) 
        error(message('MATLAB:var:integerClass'));
    end

    % prepare some values needed for both mean and variance
    n = 0;
    mean = 0.0;
    M2 = 0.0;
    s = size(image);
    rows = s(1);
    cols = s(2);
     
    for x = 1:cols
        for y = 1:rows
            n = n + 1;
            delta = image(y, x) - mean;
            mean = mean + delta/n;
            M2 = M2 + delta*(image(y,x) - mean);
        end
    end
    
    if n < 2
        v = float('nan');
    else
        v = M2 / (n - 1);
    end
end

