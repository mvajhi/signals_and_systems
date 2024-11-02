function [X , FINALOBJECT_LEN] = my_segmentation(picture)

FINALOBJECT = createobject(picture)
FINALOBJECT_LEN = size(FINALOBJECT, 2)
% Initialize the output matrix
X = zeros(size(picture));

% Loop through all found objects and only keep the ones larger than the threshold
for j = 1:size(FINALOBJECT, 2)
    for i = 1:size(FINALOBJECT{j}, 2)
        X(FINALOBJECT{j}(1, i), FINALOBJECT{j}(2, i)) = j;
    end
end

end
