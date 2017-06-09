scale = 30;
grid = ones(8*scale+1,18*scale+1);
 
%color selection aid
foo = 0.001;
for a = 1:144   
   [x,y] = transform_coordinates(a);
   grid((x-1)*(scale)+1:(x)*scale,(y-1)*scale+1:y*scale) = foo;
   foo = foo + 0.005;
end

imshow(grid)
colormap(colorcube)