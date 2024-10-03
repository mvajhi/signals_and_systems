function [a,b] = p2_4(x,y)
costFunction = @(params) sum((y - params(1)*x - params(2)).^2);

initial_guess = [0, 0]; 

p = fminsearch(costFunction, initial_guess);

a = p(1)
b = p(2)
end
