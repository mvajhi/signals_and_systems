%like before
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
picture=imresize(picture,[300 500]);
picture=rgb2gray(picture);
figure 
imshow(picture);
threshold = graythresh(picture);
picture =~imbinarize(picture,threshold);
picture = bwareaopen(picture,60);
figure 
imshow(picture);
%remove extra data
[L,Ne]=bwlabel(picture);
for i = 1:Ne 
    Q = find(L == i);
    [r,c] = find(L == i);
    if length(Q) > 400 || (max(r) - min(r)) > 35 || (max(c) - min(c)) > 35
        for j = 1:length(Q)
            picture(Q(j)) = 0;
        end
    end
    if (max(r) - min(r)) < 7 || (max(c) - min(c)) < 3
        for j = 1:length(Q)
            picture(Q(j)) = 0;
        end
    end
end
figure 
imshow(picture);
picture = imresize(picture,[300 500]); 
figure 
imshow(picture);
[L,Ne]=bwlabel(picture);
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
    Y=picture(min(r):max(r),min(c):max(c));
    Y=imresize(Y,[60,50]);
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