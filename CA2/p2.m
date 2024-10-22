clc
close all;
clear;
% SELECTING THE TEST DATA
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
picture=imresize(picture,[300 500]);
%RGB2GRAY
picture=rgb2gray(picture);
% THRESHOLDIG and CONVERSION TO A BINARY IMAGE
threshold = graythresh(picture);
picture =~imbinarize(picture,threshold);
% Removing the small objects and background
picture = bwareaopen(picture,500);
subplot(1,3,1)
imshow(picture)
background=bwareaopen(picture,6000);
subplot(1,3,2)
imshow(background)
picture2=picture-background;
subplot(1,3,3)
imshow(picture2)
% Labeling connected components
[L,Ne]=bwlabel(picture2);
propied=regionprops(L,'BoundingBox');
hold on
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off
% Loading the mapset
load TRAININGFARSISET;
totalLetters=size(FTRAIN,2);
figure
final_output=[];
t=[];
for n=1:Ne
    [r,c]=find(L==n);
    Y=picture2(min(r):max(r),min(c):max(c));
    Y=imresize(Y,[60,50]);
    imshow(Y)
    pause(0.2)
    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(FTRAIN{1,k},Y);
    end
    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        imshow(Y)
        out=cell2mat(FTRAIN(2,pos));       
        final_output=[final_output out];
    end
end
% Printing the plate
disp(final_output)