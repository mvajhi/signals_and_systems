clc
close all;
clear;
% SELECTING THE TEST DATA
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
picture=imresize(picture,[300 500]);
%RGB2GRAY
gray=mygrayfun(picture);
% THRESHOLDIG and CONVERSION TO A BINARY IMAGE
thero=100;
picbinary=mybinaryfun(gray,thero);
figure
subplot(1,2,1)
imshow(picbinary)
% Removing the small objects and background
CC=myremovecom(picbinary,300);
background=myremovecom(picbinary,3300);
picc=CC-background;
picc=~mybinaryfun(picc,thero);
subplot(1,2,2)
imshow(picc)
% Labeling connected components
[L,Ne]=mysegmention(picc);
propied=regionprops(L,'BoundingBox');
hold on
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off
% Loading the mapset
load TRAININGSET;
totalLetters=size(TRAIN,2);
figure
final_output=[];
t=[];
for n=1:Ne
    [r,c]=find(L==n);
    Y=picc(min(r):max(r),min(c):max(c));
    Y=imresize(Y,[42,24]);
    pause(0.2)
    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(TRAIN{1,k},Y);
    end
    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        imshow(Y)
        out=cell2mat(TRAIN(2,pos));       
        final_output=[final_output out];
    end
end
% Printing the plate
file = fopen('number_Plate.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
winopen('number_Plate.txt')
function gray=mygrayfun(image)
    gray=zeros(300,500);
    for i=1:300
        for j=1:500
            gray(i,j)=image(i,j,1)*0.299+image(i,j,2)*0.578+image(i,j,3)*0.114;
        end
    end
end
function picbinary=mybinaryfun(pic,thero)
    picbinary=zeros(300,500);
    for i=1:300
        for j=1:500
            if pic(i,j)<=thero
                picbinary(i,j)=1;
            elseif pic(i,j)>thero
                picbinary(i,j)=0;
            end
        end
    end 
end
function CC=myremovecom(picbinary,n)
 CC = zeros(300, 500);
 flag = 1;
 memory = zeros(300, 500);
 for i = 1:300
    for j = 1:500
        if picbinary(i, j) == 1 && memory(i, j) == 0
            S= [i, j];
            memory(i, j) = flag;
            while ~isempty(S)
                pixel = S(1, :);
                S(1, :) = [];
                for k = -1:1
                    for l = -1:1
                        new_x = pixel(1) + k;
                        new_y = pixel(2) + l;
                        if new_x >= 1 && new_y >= 1 && new_x <= 300 && new_y <= 500 && ...
                           picbinary(new_x, new_y) == 1 && memory(new_x, new_y) == 0
                           S = [S; new_x, new_y];
                           memory(new_x, new_y) = flag;
                        end
                    end
                end
            end
            size = sum(memory(:) == flag);
            if size >= n
                CC(memory == flag) = 255;
            end
            flag = flag + 1;
        end
    end
end
end
function [L,Ne] = mysegmention(picc)
 flag = 1;
 L = zeros(300,500);
 for i = 1:500
    for j = 1:300
        if picc(j, i) == 1 && L(j, i) == 0
            S = [j, i];
            L(j, i) = flag;
            while ~isempty(S)
                current_pixel = S(1, :);
                S(1, :) = [];
                for k = -1:1
                    for l = -1:1
                        new_x = current_pixel(1) + k;
                        new_y = current_pixel(2) + l;
                        if new_x >= 1 && new_x <= 300 && new_y >= 1 && new_y <= 500 &&...
                            picc(new_x, new_y) == 1 && L(new_x, new_y) == 0
                        S = [S; new_x, new_y];
                        L(new_x, new_y) = flag;
                        end
                    end
                end
            end
            Ne=flag;
            flag = flag + 1;
        end
    end
end
end