function grid = visualizePersonalInit(robotcolors, sys, offset, scale, grid, environment, index)
global blackvalue;
global redvalue

grid=squeeze(grid);
colors = zeros(environment.x*scale+1,environment.y*scale+1);
colorsadd = zeros(environment.x*scale+1,environment.y*scale+1);
N=length(sys);
% show the regions where services can be provided
i=index;
ts=sys(i);
servicelocation=find(~cellfun(@isempty, ts.ser));
[x,y] =  transform_coordinates(servicelocation);
sizex=size(x);
for j=1:sizex(2)
    colors(x(j), y(j))=colors(x(j), y(j))+1;
end



i=index;
ts=sys(i);
servicelocation=find(~cellfun(@isempty, ts.ser));
[x,y] =  transform_coordinates(servicelocation);
sizex=size(x);
for j=1:sizex(2)
    if(colors(x(j), y(j))==1)
        grid((x(j)-1)*(scale)+1:(x(j))*scale,(y(j)-1)*scale+1:(y(j))*scale) = robotcolors(i); 
    else
        colorsize=scale/colors(x(j), y(j));
        colorstart=colorsize*colorsadd(x(j), y(j));
        grid((x(j)-1)*(scale)+1:(x(j))*scale,(y(j)-1)*scale+1+colorstart:(y(j))*scale+colorstart+colorsize) = robotcolors(i); 
        colorsadd(x(j), y(j))=colorsadd(x(j), y(j))+1;
    end
end


%grid lines
for i = 0:environment.y
    for j = 1:environment.x*scale+1
        grid(j, i*scale+1) = blackvalue;
    end
end

for j=0:environment.x
    for i = 1:environment.y*scale+1
        grid(j*scale+1,i) = blackvalue;
    end
end


environmentsize=environment.x*environment.y;
for j=1:environmentsize
   for k=j+1:environmentsize
       if(environment.map(j,k)==0)
          ydistance=abs(fix((k/environment.y))-fix((j/environment.y)));
          xdistance=abs(mod(k, environment.y)-mod(j, environment.y));
         
          if((xdistance+ydistance==1))
          [x,y] =  transform_coordinates([j, k]);
         
              if((ydistance==0) && x(1)==x(2))
                   grid((x-1)*(scale)+1:(x)*scale,(y)*scale-1:(y)*scale+1) = blackvalue;
              end
              if(xdistance==0 && y(1)==y(2))
                 grid((x-1)*(scale)-1:(x-1)*scale+1,(y-1)*scale+1:y*scale) = blackvalue;
              end
          end
       end
   end
end


if(isfield(environment, 'pmap'))
    for j=1:environmentsize
        for k=j+1:environmentsize
             if(abs(environment.pmap(j,k)-environment.map(j,k))==1)
                 if(environment.map(j,k)==0)
                      ydistance=abs(fix((k/environment.y))-fix((j/environment.y)));
                      xdistance=abs(mod(k, environment.y)-mod(j, environment.y));
                      if((xdistance+ydistance==1))
                          [x,y] =  transform_coordinates([j, k]);
                          if((ydistance==0) && x(1)==x(2))
                               grid((x-1)*(scale)+1:(x)*scale,(y)*scale-1:(y)*scale+1) = redvalue;
                          end
                          if(xdistance==0 && y(1)==y(2))
                             grid((x-1)*(scale)-1:(x-1)*scale+1,(y-1)*scale+1:y*scale) = redvalue;
                          end
                      end
                 end
             end
        end
    end
end

%walls  left right
%for a = [6,12,60,78,132,12+3*18]
%    [x,y] = transform_coordinates(a);
%    grid((x-1)*(scale)+1:(x)*scale,y*scale-1:y*scale+1) = blackvalue;
%end

%walls  up down
%for a = [91,91+1,91+4,91+5,79,80,83,84,85,86,89,90]
%    [x,y] = transform_coordinates(a);
%    grid((x)*(scale)-1:(x)*scale+1,(y-1)*scale+1:y*scale) = blackvalue;
%end

i=index;
color = robotcolors(i);
[x,y]= transform_coordinates(sys(i).curr);
grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = color;


c=colorcube(64);

subplot(N,1,i), imshow(grid, c);
pause(3)
