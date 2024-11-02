IC = imread('./data/IC.png');
PCB = imread('./data/PCB.jpg');
threshold = 0.7; % Adjust this value as needed

ICrecognition(IC, PCB, threshold);
