function [POINTS,newPoints]=close_points(initpoint,POINTS)

POINTS_NUM=size(POINTS,2);
DIF=repmat(initpoint,1,POINTS_NUM)-POINTS;
DIF=abs(DIF);
ind=find(DIF(1,:)<=1 & DIF(2,:)<=1);
newPoints=POINTS(:,ind);

POINTS(:,ind)=[];
end