
[file, path] = uigetfile('*.jpg; *.png ;*.bmp; *.tif', 'Input MapSet Folder');

s=[path,file];
picture = imread(s);
figure

subplot(2,2,1);
imshow(picture);
 
rowPixels = 300;
colPixels = 500;
resized_picture = imresize(picture, [rowPixels, colPixels]);

subplot(2,2,2);
imshow(resized_picture);

gray_picture = mygrayfun(resized_picture); % Replaced with my function 

subplot(2,2,3);
imshow(gray_picture);

% threshold = graythresh(gray_picture);
threshold = 128;
binarized_picture = mybinaryfun(gray_picture, threshold); % Replaced with my function

subplot(2,2,4);
imshow(binarized_picture);

binarized_picture = ~binarized_picture;
lower_threshold = 1000;
cleaned_picture = myremovecom(binarized_picture, lower_threshold);
upper_threshold = 2500;
cleaned_picture = cleaned_picture - myremovecom(binarized_picture, upper_threshold);
figure
imshow(cleaned_picture);

labeled_picture = mysegmentation(cleaned_picture);

[L,Nseg]=mysegmentation(cleaned_picture);


load TRAININGSET;
totalLetters=size(TRAIN,2);

figure
final_output=[];
t=[];
for n=1:Nseg
    
    [r,c]=find(L==n);
    Y=labeled_picture(min(r):max(r),min(c):max(c));
    imshow(Y)
    Y=imresize(Y,[42,24]);
    imshow(Y)
    pause(0.2)

    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(TRAIN{1,k},Y);
    end

    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        out=TRAIN{2,pos};       
        final_output=[final_output out];
    end
end


% Printing the plate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file = fopen('number_Plate.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
winopen('number_Plate.txt')