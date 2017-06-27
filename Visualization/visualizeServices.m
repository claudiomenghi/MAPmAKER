global blackvalue;
global whitevalue;
global c;
global scale;
global legendText;
global robotcolors;
global customfontsize;

tmp=size(sys);
N=tmp(2); 



for i=1:N
%% printing services
    servicelocation=find(~cellfun(@isempty, sys(i).ser));
         
    sizex=size(servicelocation);
    for j=1:sizex(2)
            [x,y] =  transform_coordinates(servicelocation(j), environment.x, environment.y);
            
            textToBePrinted=sys(i).ser(servicelocation(j));
            t =text((y-1)*scale+scale/7,(x-1)*scale+(scale/(N+1)*i),mat2str(textToBePrinted{1}));
            t.Color=robotcolors(i,:);
            t.FontSize =customfontsize;
            
    end
    
%% printing possible services    
    possibleservicelocation=find(~cellfun(@isempty, sys(i).pser));
         
    sizex=size(possibleservicelocation);
    for j=1:sizex(2)
            
            if(~ismember(possibleservicelocation(j),servicelocation))
                [x,y] =  transform_coordinates(possibleservicelocation(j), environment.x, environment.y);

                services=sys(i).pser(possibleservicelocation(j));
                textToBePrinted='';
                for k=1:size(services{1},2)
                    textToBePrinted=strcat(textToBePrinted,'?',int2str(services{1}(1,k)),char(9));
                end
                t =text((y-1)*scale+scale/7,(x-1)*scale+(scale/(N+1)*i),textToBePrinted);
                t.Color=robotcolors(i,:);
                t.FontSize =customfontsize;
            end
    end
end 

%% displays the robot initial positions
for i=1:N
    [x,y] =  transform_coordinates(sys(i).init, environment.x, environment.y);
    t =text((y-1)*scale,(x-1)*scale+scale/5, strcat('Robot', int2str(i)));
    t.Color=robotcolors(i,:);
    t.FontSize =customfontsize;
end