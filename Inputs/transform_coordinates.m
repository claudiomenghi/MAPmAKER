function [x,y] = transform_coordinates(a)

x = 8-(floor((a-1)/18));
y = mod(a,18);

for i=1:length(x)
if x(i) == 0 
    x(i) = 1;
end
end
for i=1:length(y)
if y(i) == 0 
    y(i) = 18;
end
end