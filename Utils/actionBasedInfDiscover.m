% updates the system with new information about the environment
function [sys, grid, environment, infdiscovered, evidence] = actionBasedInfDiscover(grid, sys, environment, realenvironment, robotindex, source, destination, plotenabled)
%%  discovers information regarding the transition between source and destination
    xmax=environment.x;
    ymax=environment.y;
    discovered=ones(environment.x*environment.y,environment.x*environment.y)*3;
    infdiscovered=0;
    N=size(sys,2);
        % check whether there exists a possible transition close to the
        % current location
        %if 
        
        evidence=1;
        if(abs(sys(robotindex).adj(source,destination)-sys(robotindex).padj(source,destination))==1)
             fprintf('checking for new knowledge observed from one of the robots\n');
       
              % simulates the discovering of info
              evidence=full(realenvironment.map(source,destination));
              
              environment.map(source,destination)=evidence;
              environment.map(destination, source)=environment.map(source,destination);
              environment.pmap(source,destination)=environment.map(source,destination);
              environment.pmap(destination, source)= environment.pmap(source,destination);
              discovered(source,destination)=evidence;
              discovered(destination, source)=evidence;
              fprintf('Robot %d acquired new knowledge ', robotindex);
              [x,y]= transform_coordinates_index2xy(source, xmax, ymax);
              [xdest,ydest]= transform_coordinates_index2xy(destination, xmax, ymax);
              fprintf('knowledge %d about the transition between [x,y]=[%d, %d] and [x+1,y+1]=[%d, %d] added', evidence, x, y, xdest,ydest);
              infdiscovered=1;
        end
        if ~isequal(sys(robotindex).pser(destination),sys(robotindex).ser(destination))
            if ~isempty(sys(robotindex).compser(destination))
                infdiscovered=1;
            end 
            sys(robotindex).pser(destination)=sys(robotindex).compser(destination);
            sys(robotindex).ser(destination)=sys(robotindex).compser(destination);
        end
        
    % notifies the other robots with the new information
        
     for r2=1:N
         sys(r2).adj=environment.map;
         sys(r2).padj=environment.pmap;
     end

     if(plotenabled==1)
         grid=visualizeDiscoveredGrid(grid, environment, sys, discovered);
     end
  
 
end