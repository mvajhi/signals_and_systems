function FINALOBJECT =createobject(picture)
% Find the row and column indices of the foreground pixels
[row, col] = find(picture == 1);
POINTS = [row'; col'];
POINTS_NUM = size(POINTS, 2);

% Initialize the first point
initpoint = POINTS(:, 1);
POINTS(:, 1) = [];
POINTS_NUM = POINTS_NUM - 1;
CurrectObject = [initpoint];
t = 1;

% Loop through until all points are processed
while POINTS_NUM > 0
    [POINTS, newPoints] = close_points(initpoint, POINTS);
    newPoints_len = size(newPoints, 2);
    CurrectObject = [CurrectObject, newPoints];
   
    % Check for additional connected points
    while newPoints_len > 0
        initpoint = newPoints(:, 1);
        newPoints(:, 1) = [];
        [POINTS, newPoints2] = close_points(initpoint, POINTS);
        CurrectObject = [CurrectObject, newPoints2];
        newPoints = [newPoints, newPoints2];
        newPoints_len = size(newPoints, 2);
    end
   
    % Store the current object in the final list of objects
    FINALOBJECT{t} = CurrectObject;
    t = t + 1;
    POINTS_NUM = size(POINTS, 2);
    if POINTS_NUM > 0
        initpoint = POINTS(:, 1);
        CurrectObject = initpoint;
    end
end

end