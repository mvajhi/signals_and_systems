function X = myremovecom(picture, threshold)

FINALOBJECT =createobject(picture)
% Initialize the output matrix
X = zeros(size(picture));

% Loop through all found objects and only keep the ones larger than the threshold
for j = 1:size(FINALOBJECT, 2)
    if size(FINALOBJECT{j}, 2) >= threshold
        for i = 1:size(FINALOBJECT{j}, 2)
            X(FINALOBJECT{j}(1, i), FINALOBJECT{j}(2, i)) = 1;
        end
    end
end

end
