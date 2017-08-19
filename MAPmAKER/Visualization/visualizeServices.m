function grid = visualizeServices(sys, offset, scale, grid, environment)    

    global robotcolors;
    global customfontsize;
    global green;
    global whitevalue;
    global c;

    tmp=size(sys);
    N=tmp(2); 

    %% displays the sync
    tmpsync=zeros(size(sys(1).Q,2));
    for i=1:N
        for j=1:length(sys(i).Q)
            if ~isequal(sys(i).psync{j},  sys(i).sync{j})
                tmpsync(j)=1;
            end
        end
    end
    for i=1:N
        for j=1:length(sys(i).Q)
            if tmpsync(j)==1
                [x,y]= transform_coordinates(j, environment.x, environment.y);
                num=18;
                num2=round(num/3);
                
                A=repmat(green-whitevalue,1,num2);
                
                WHITE=repmat(whitevalue, num2, num2);
                M=diag(A);
                C=flipdim(M ,1);   
               
                B=M+C+WHITE;
%                grid(1:num2,1:num2)=B;
                startx=(x-1)*scale+scale/2+offset(i)+num2*2+1;
                endx=(x-1)*scale+scale/2+offset(i)+num2*3;
                starty=(y-1)*scale+scale/2+offset(i)+num2*2+1;
                endy=(y-1)*scale+scale/2+offset(i)+num2*3;
                grid(startx:endx,starty:endy) = B;
            else
                [x,y]= transform_coordinates(j, environment.x, environment.y);
                num=18;
                num2=round(num/3);
                
                
                WHITE=repmat(whitevalue, num2, num2);
               
                B=WHITE;
%                grid(1:num2,1:num2)=B;
                startx=(x-1)*scale+scale/2+offset(i)+num2*2+1;
                endx=(x-1)*scale+scale/2+offset(i)+num2*3;
                starty=(y-1)*scale+scale/2+offset(i)+num2*2+1;
                endy=(y-1)*scale+scale/2+offset(i)+num2*3;
                grid(startx:endx,starty:endy) = B;
            end
        end
        
    end
    global f;
    imshow(grid, c,'InitialMagnification','fit');
   
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
    
    
end