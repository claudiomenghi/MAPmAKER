function [x,y] = transform_coordinates(a, maxX, maxY)
%% transforms a cell into its
x = maxX-(floor((a-1)/maxY));
y = mod(a,maxY);

for i=1:length(x)
if x(i) == 0 
    x(i) = 1;
end
end
for i=1:length(y)
if y(i) == 0 
    y(i) = maxY;
end
end