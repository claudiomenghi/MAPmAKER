function [falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1, planlengthstep2, planningtimestep2, solutionfoundstep2]= experimentRunner(sys, spec, environment)

        global offset;
        global scale;
                global whitevalue;
                global c;
        plotenabled=1;

        %figure;
        % Create a new figure
        f = figure;

        % Set a size if desired
        width = 800;
        height = 600;
        set(f,'Position',[15 15 width height])
        % Change the renderer to avoid bugs due to OpenGL
        set(f,'Renderer','ZBuffer')

        if(plotenabled==1)
            grid = ones(environment.x*scale+1,environment.y*scale+1)*whitevalue;
            grid=visualizeGrid(grid, environment);
            imshow(grid, c);
            grid = visualizeInit(sys, offset, scale, grid, environment);
            visualizeServices;
        else
            grid=[];
        end
        
        maxIteration=50;
      
        %% runs the step 1 of the evaluation
        possiblesearchenabled=1;
        
        sys1=sys;
        spec1=spec;
        [falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1]=mapmaker(sys, spec, environment, possiblesearchenabled, maxIteration, plotenabled, grid,  offset, scale);

        %% runs the step 2 of the evaluation
        possiblesearchenabled=0;
        [falseEvicenceCounterstep2, trueEvidenceCounterstep2, planlengthstep2, planningtimestep2, solutionfoundstep2]=mapmaker(sys1, spec1, environment, possiblesearchenabled, maxIteration, plotenabled, grid,  offset, scale);

      

end