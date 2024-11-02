IC = imread('IC.png');
PCB = imread('PCB.jpg');
threshold = 0.7; % Adjust this value as needed

ICrecognition(IC, PCB, threshold);
