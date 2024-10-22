clc
close all;
clear;
% SELECTING THE TEST DATA
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
picture=imresize(picture,[400 800]);
picture=rgb2gray(picture);
threshold = graythresh(picture);
picture =~imbinarize(picture,threshold);
subplot(1,3,1)
imshow(picture)
mappp='D:\ut term 4\signal\2\CA2\mappp.png';
corr=imread(mappp);
corr=imresize(corr,[80 160]);
map=rgb2gray(corr);
threshold1 = graythresh(map);
out1 =~imbinarize(map,threshold1);
subplot(1,3,2)
imshow(out1)
roo=zeros(80,160);
for j=1:80
        roo(j,2*j)=picture(j,2*j);
end
ro=zeros(1,16);
for i=0:4
    for j=1:160
        for t=1:80
            roo(t,j)=picture(i*80+t,i*160+j);
        end
    end
    ro(1)=corr2(roo,out1);
end