function grid = visualizeInit(sys, offset, scale, grid, environment)
global blackvalue;
global c;
global legendText;
global robotcolors2;


colors = zeros(environment.x*scale+1,environment.y*scale+1);
N=length(sys);

%% displays the regions where services can be provided
for i=1:N
    ts=sys(i);
    servicelocation=find(~cellfun(@isempty, ts.ser));
    [x,y] =  transform_coordinates_index2xy(servicelocation, environment.x, environment.y);
    sizex=size(x);
    for j=1:sizex(2)
        colors(x(j), y(j))=colors(x(j), y(j))+1;
    end
end

%% displays the initial robot position
for i=1:N
    [x,y]= transform_coordinates(sys(i).curr, environment.x, environment.y);
    grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = robotcolors2(i);
end


%% displays the legend
global actions;
global legentactionperrow;
dim=size(actions);


legendText=cell(ceil(dim(2)/legentactionperrow)+1);
dim2=size(legendText);

for i=1:dim2(2)
   legendText{i}='';
end

for i=1:dim(2)
     legendText{ceil(i/legentactionperrow)}=sprintf([legendText{ceil(i/legentactionperrow)}, int2str(i), '=', mat2str(actions{i}), char(9), char(9), char(9)]);
end


for i=1:dim2(2)
   legendText{i}=sprintf([legendText{i}, char(9), char(9), char(9), char(9), char(9), char(9), char(9), char(9)]);
end

imshow(grid, c,'InitialMagnification','fit');
visualizeServices(sys, offset, scale, grid, environment);
%xlabel(legendText)

pause(3)
