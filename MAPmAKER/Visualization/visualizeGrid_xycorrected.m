function grid = visualizeGrid(grid, environment)

global blackvalue;
global redvalue;
global c;
global scale;
global linewidth;

figure(87);
imshow(grid, c);
tam=size(grid)

xv=0;
xv=environment.x;
environment.x=environment.y;
environment.y=xv;

%% grid visualization
% for i = 0:environment.y
%     for j = 1:environment.x*scale+1
%         grid(i*scale+1:i*scale+1+linewidth, j) = blackvalue; %
%     end
% end
% xv=i
% yv=j
% tam=size(grid)
% 
% figure(88);
% imshow(grid, c);
% 
% 
% for j=0:environment.x
%     for i = 1:environment.y*scale+1
%         grid(i, j*scale+1:j*scale+1+linewidth) = blackvalue; %
%     end
% end
% xv=i
% yv=j
% tam=size(grid)
% 
% figure(89);
% imshow(grid);


for i = 0:environment.y
    for j = 1:environment.x*scale+1
        grid(j, i*scale+1:i*scale+1+linewidth) = blackvalue;
    end
end
figure(88); imshow(grid, c);
for j=0:environment.x
    for i = 1:environment.y*scale+1
        grid(j*scale+1:j*scale+1+linewidth,i) = blackvalue;
    end
end
figure(89); imshow(grid, c);

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
                 (x-1)*(scale)+1
                 (x)*scale
                 (y)*scale-1
                 (y)*scale+1
              end
               if(xdistance==0 && y(1)==y(2))
                 grid((x-1)*(scale)-1:(x-1)*scale+1,(y-1)*scale+1:y*scale) = blackvalue;
              end
          end
       end
   end
end
tam=size(grid)


% if(isfield(environment, 'pmap'))
%     environmentsize=environment.x*environment.y;
%     for j=1:environmentsize
%        for k=j+1:environmentsize
%            if(abs(environment.pmap(j,k)-environment.map(j,k))==1)
%               ydistance=abs(fix((k/environment.y))-fix((j/environment.y)));
%               xdistance=abs(mod(k, environment.y)-mod(j, environment.y));
% 
%               if((xdistance+ydistance==1))
%               [x,y] =  transform_coordinates([j, k], environment.x, environment.y);
% 
%                   if((ydistance==0) && x(1)==x(2))
%                        grid((x-1)*(scale)+1:(x)*scale,(y)*scale-1:(y)*scale+1) = redvalue;
%                   end
%                   if(xdistance==0 && y(1)==y(2))
%                      grid((x-1)*(scale)-1:(x-1)*scale+1,(y-1)*scale+1:y*scale) = redvalue;
%                   end
%               end
%            end
%        end
%     end
% end
tam=size(grid)


%imshow(grid, c);
end



