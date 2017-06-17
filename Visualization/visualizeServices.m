
tmp=size(sys);
N=tmp(2); 

global robotcolors;
global customfontsize;

for i=1:N
    servicelocation=find(~cellfun(@isempty, sys(i).ser));
         
    sizex=size(servicelocation);
    for j=1:sizex(2)
            [x,y] =  transform_coordinates(servicelocation(j), environment.x, environment.y);
            
            textToBePrinted=sys(i).ser(servicelocation(j));
            t =text((y-1)*scale+scale/7,(x-1)*scale+(scale/(N+1)*i),mat2str(textToBePrinted{1}));
            t.Color=robotcolors(i,:);
            t.FontSize =customfontsize;
            
    end
end 

%% displays the robot initial positions
for i=1:N
    [x,y] =  transform_coordinates(sys(i).init, environment.x, environment.y);
    t =text((y-1)*scale,(x-1)*scale+scale/5, strcat('Robot', int2str(i)));
    t.Color=robotcolors(i,:);
    t.FontSize =customfontsize;
end