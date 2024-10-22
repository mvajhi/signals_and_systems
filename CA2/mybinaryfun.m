function binarized_picture = mybinaryfun(gray_picture, threshold)
    
    [rowNum, colNum] = size(gray_picture);

    binarized_picture = zeros(rowNum, colNum);

    for i = 1:rowNum
        for j = 1:colNum
            if gray_picture(i, j) >= threshold
                binarized_picture(i, j) = 1;
            else
                binarized_picture(i, j) = 0;
            end
        end
    end
end
