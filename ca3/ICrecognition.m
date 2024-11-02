function ICrecognition(templateImage, mainImage, threshold)
    % ICrecognition: Finds and marks areas in mainImage similar to templateImage
    % using normalized cross-correlation.
    %
    % Inputs:
    %   - templateImage: The template image (IC Image) to search for
    %   - mainImage: The main image (PCB Image) where to search the template
    %   - threshold: Correlation threshold to mark significant matches

    % Convert to grayscale if needed
    if size(templateImage, 3) == 3
        templateImage = rgb2gray(templateImage);
    end
    if size(mainImage, 3) == 3
        grayMainImage = rgb2gray(mainImage);
    end

    % Compute normalized cross-correlation
    correlationMatrix = normxcorr2(templateImage, grayMainImage);
    
    % Rotate the template by 180 degrees and compute cross-correlation
    templateRotated = imrotate(templateImage, 180);
    correlationMatrixRotated = normxcorr2(templateRotated, grayMainImage);

    % Display the main image with rectangles overlaid
    figure;
    imshow(mainImage);
    title('Matching Result');
    hold on; % Hold on to overlay rectangles

    % Threshold and find local maxima for original template
    significantLocalMaxima1 = imregionalmax(correlationMatrix) & (correlationMatrix > threshold);
    [rows1, cols1] = find(significantLocalMaxima1);
    % Adjust coordinates for padding
    [rows1_adj, cols1_adj] = deal(rows1 - size(templateImage, 1) + 1, cols1 - size(templateImage, 2) + 1);

    % Draw blue rectangles for original template matches
    for i = 1:length(rows1_adj)
        pos = [cols1_adj(i), rows1_adj(i), size(templateImage, 2), size(templateImage, 1)];
        rectangle('Position', pos, 'EdgeColor', 'b', 'LineWidth', 2);
    end

    % Threshold and find local maxima for rotated template
    significantLocalMaxima2 = imregionalmax(correlationMatrixRotated) & (correlationMatrixRotated > threshold);
    [rows2, cols2] = find(significantLocalMaxima2);
    % Adjust coordinates for padding
    [rows2_adj, cols2_adj] = deal(rows2 - size(templateImage, 1) + 1, cols2 - size(templateImage, 2) + 1);

    % Draw green rectangles for rotated template matches
    for j = 1:length(rows2_adj)
        pos = [cols2_adj(j), rows2_adj(j), size(templateImage, 2), size(templateImage, 1)];
        rectangle('Position', pos, 'EdgeColor', 'g', 'LineWidth', 2);
    end

    hold off;
end
