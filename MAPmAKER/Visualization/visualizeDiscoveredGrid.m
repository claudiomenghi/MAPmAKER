function grid = visualizeDiscoveredGrid( grid, environment, sys, discovered)

global blackvalue;
global whitevalue;
global c;
global scale;
global legendText;
global offset;


environmentsize=environment.x*environment.y;
for j=1:environmentsize
   for k=j+1:environmentsize
       if(discovered(j,k)==0)
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
       if(discovered(j,k)==1)
          ydistance=abs(fix((k/environment.y))-fix((j/environment.y)));
          xdistance=abs(mod(k, environment.y)-mod(j, environment.y));
         
          if((xdistance+ydistance==1))
              [x,y] =  transform_coordinates([j, k], environment.x, environment.y);
         
              if((ydistance==0) && x(1)==x(2))
                 grid((x-1)*(scale)+1:(x)*scale,(y)*scale-1:(y)*scale+1) = whitevalue;
              end
               if(xdistance==0 && y(1)==y(2))
                 grid((x-1)*(scale)-1:(x-1)*scale+1,(y-1)*scale+1:y*scale) = whitevalue;
              end
          end
       end
   end
end


imshow(grid, c,'InitialMagnification','fit');
visualizeServices(sys, offset, scale, grid, environment)    ;
xlabel(legendText);

end
