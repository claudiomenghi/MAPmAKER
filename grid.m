
axis equal;
axis([0 18 0 8]);
rectangle('Position',[0,0,18,8]);
for i = 1:18
    X = [i,i];
    Y = [0,8];
    line(X,Y,'Color',[0.8,0.8,0.8]);
end

for i = 1:8
    X = [0,18];
    Y = [i,i];
    line(X,Y,'Color',[0.8,0.8,0.8]);
end