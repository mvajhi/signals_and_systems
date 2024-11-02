v = '~/code/signals_and_systems/ca2/v.mp4'
trafficVid = VideoReader(v)
im = read(trafficVid,1)
picture=im

figure
subplot(1,2,1)
imshow(picture)
picture=imresize(picture,[300 500]);
subplot(1,2,2)
imshow(picture)

%RGB2GRAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
picture=rgb2gray(picture);
figure
subplot(1,2,1)
imshow(picture)

% THRESHOLDIG and CONVERSION TO A BINARY IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold = graythresh(picture);
picture =imbinarize(picture,threshold);
subplot(1,2,2)
imshow(picture)



% CROPING the image 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % hazf 1/3 balaie image
% [height , width , ~ ] = size(picture);
% down_third = picture (height/3+1 : end , : , : );
% picture = down_third;
% 
% % %hazf 1/5 paeeni image
% % [height , width , ~ ] = size(picture);
% % 
% % top_fifth = picture (1 : height/5, : , : );
% % picture = top_fifth;
% 
% % hazf 1/5 kenar chap image
% [height , width , ~ ] = size(picture);
% left_fifth = picture (: , floor(1*width/5)+1:end , :);
% picture = left_fifth;
% 
% 
% % hazf 1/5 kenar rast image
% [height , width , ~ ] = size(picture);
% % 21 /25pic = 1pic  - 1/5pic * 4/5pic
% right_fifth = picture (: , 1:floor(21*width/25)+1 , :);
% picture = right_fifth;
% 

figure 
imshow(picture);





% Removing the small objects and background
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
picture = bwareaopen(picture,400); % removes all connected components (objects) that have fewer than 500 pixels from the binary image
subplot(1,3,1)
imshow(picture)
background=bwareaopen(picture,5000);
subplot(1,3,2)
imshow(background)
picture2=picture-background;
subplot(1,3,3)
imshow(picture2)

% 
% %  barax kardan 0 to 1 
% figure 
% picture2 = ~picture2;
% imshow(picture2);





% Labeling connected components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
imshow(picture2)
[L,Ne]=bwlabel(picture2);
propied=regionprops(L,'BoundingBox');
hold on
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off


%%%% 
%ration pelak : 4.5 < x < 6.5
%
%output of bounding box : x-top-left , y-top-left , width , heigth 
%%%%
goodObj = [] ;
for obj=1:size(propied , 1)
    wPerH = propied(obj).BoundingBox(3) / propied(obj).BoundingBox(4);
    if 4<= wPerH && wPerH <= 7
        goodObj = [goodObj propied(obj)];
    end
end







for i= 1:size(goodObj , 2)
    x = goodObj(i).BoundingBox(1);
    y = goodObj(i).BoundingBox(2);
    w = goodObj(i).BoundingBox(3);
    h = goodObj(i).BoundingBox(4);

    
    theImage = picture2(y:y+h-1 , x:x+w-1 , :);
    a = (y + (y+h-1))/2
b = (x + (x+w-1))/2
    hold on
    plot(b,a,'r.',MarkerSize=20);


end

