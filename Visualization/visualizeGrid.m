function grid = visualizeGrid(grid, environment)

global blackvalue;
global redvalue;
global c;
global scale;
global linewidth;

%% grid visualization
for i = 0:environment.y
    for j = 1:environment.x*scale+1
        grid(j, i*scale+1:i*scale+1+linewidth) = blackvalue;
    end
end

for j=0:environment.x
    for i = 1:environment.y*scale+1
        grid(j*scale+1:j*scale+1+linewidth,i) = blackvalue;
    end
end

imshow(grid, c);


%% obstacle visualization
environmentsize=environment.x*environment.y;
for j=1:environmentsize
   for k=j+1:environmentsize
       if(environment.map(j,k)==0)
          ydistance=abs(fix((k/environment.y))-fix((j/environment.y)));
          xdistance=abs(mod(k, environment.y)-mod(j, environment.y));
         
          if((xdistance+ydistance==1))
          [x,y] =  transform_coordinates([j, k], environment.x, environment.y);
         
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
    environmentsize=environment.x*environment.y;
    for j=1:environmentsize
       for k=j+1:environmentsize
           if(abs(environment.pmap(j,k)-environment.map(j,k))==1)
              ydistance=abs(fix((k/environment.y))-fix((j/environment.y)));
              xdistance=abs(mod(k, environment.y)-mod(j, environment.y));

              if((xdistance+ydistance==1))
              [x,y] =  transform_coordinates([j, k], environment.x, environment.y);

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

imshow(grid, c);
end



