function gray_picture = mygrayfun(picture)
    
    redChannel = picture(:, :, 1); 
    greenChannel = picture(:, :, 2); 
    blueChannel = picture(:, :, 3);

    gray_picture = 0.299 * redChannel + 0.587 * greenChannel + 0.114 * blueChannel;
end
