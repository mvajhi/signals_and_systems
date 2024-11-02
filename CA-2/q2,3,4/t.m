function [a, b] = process_image(picture)

    figure;
    subplot(1,2,1);
    imshow(picture);
    picture = imresize(picture, [300 500]);
    subplot(1,2,2);
    imshow(picture);

    picture = rgb2gray(picture);
    figure;
    subplot(1,2,1);
    imshow(picture);

    threshold = graythresh(picture);
    picture = imbinarize(picture, threshold);
    subplot(1,2,2);
    imshow(picture);

    [height, width, ~] = size(picture);
    left_fifth = picture(:, floor(1 * width / 5) + 1:end, :);
    picture = left_fifth;

    [height, width, ~] = size(picture);
    right_fifth = picture(:, 1:floor(21 * width / 25) + 1, :);
    picture = right_fifth;

    figure;
    imshow(picture);

    figure;
    picture = bwareaopen(picture, 400);
    subplot(1,3,1);
    imshow(picture);
    background = bwareaopen(picture, 5000);
    subplot(1,3,2);
    imshow(background);
    picture2 = picture - background;
    subplot(1,3,3);
    imshow(picture2);

    figure;
    imshow(picture2);
    [L, Ne] = bwlabel(picture2);
    propied = regionprops(L, 'BoundingBox');
    hold on;
    for n = 1:size(propied, 1)
        rectangle('Position', propied(n).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 2);
    end
    hold off;

    goodObj = [];
    for obj = 1:size(propied, 1)
        wPerH = propied(obj).BoundingBox(3) / propied(obj).BoundingBox(4);
        if 4 <= wPerH && wPerH <= 7
            goodObj = [goodObj propied(obj)];
        end
    end

    a_vals = [];
    b_vals = [];
    for i = 1:size(goodObj, 2)
        x = goodObj(i).BoundingBox(1);
        y = goodObj(i).BoundingBox(2);
        w = goodObj(i).BoundingBox(3);
        h = goodObj(i).BoundingBox(4);

        theImage = picture2(y:y + h - 1, x:x + w - 1, :);
        a = (y + (y + h - 1)) / 2;
        b = (x + (x + w - 1)) / 2;
        hold on;
        plot(b, a, 'r.', 'MarkerSize', 20);
    end
end

v = '~/code/signals_and_systems/ca2/v.mp4';
trafficVid = VideoReader(v);

% فریم 1
im1 = read(trafficVid, 1);
[a_vals1, b_vals1] = process_image(im1);

% فریم 20
im20 = read(trafficVid, 20);
[a_vals20, b_vals20] = process_image(im20);

% ذخیره مقادیر a و b
a_b_frame1 = [a_vals1, b_vals1];
a_b_frame20 = [a_vals20, b_vals20];

% نمایش نتایج
disp('a, b for frame 1:');
disp(a_b_frame1);
disp('a, b for frame 20:');
disp(a_b_frame20);
