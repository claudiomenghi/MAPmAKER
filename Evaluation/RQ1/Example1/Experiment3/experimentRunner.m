function [falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1, planlengthstep2, planningtimestep2, solutionfoundstep2, performedpathstep1, performedpathstep2]= experimentRunner(sys, spec, environment, realenvironment, experimentNumber)

        global offset;
        global scale;
        
        plotenabled=1;

        
        maxIteration=10;
        
        %% runs the step 1 of the evaluation
        possiblesearchenabled=1;
        
        sys1=sys;
        spec1=spec;
        environment1=environment;
        realenvironment1=realenvironment;
        
        video_name=sprintf('movie_%d_Step1', experimentNumber);
        
        [falseEvicenceCounterstep1, trueEvidenceCounterstep1, planlengthstep1, planningtimestep1, solutionfoundstep1, performedpathstep1]=mapmaker(sys, spec, environment, realenvironment, possiblesearchenabled, maxIteration, plotenabled,   offset, scale, video_name);

        %% runs the step 2 of the evaluation
        possiblesearchenabled=0;
        video_name=sprintf('movie_%d_Step2', experimentNumber);
        [falseEvicenceCounterstep2, trueEvidenceCounterstep2, planlengthstep2, planningtimestep2, solutionfoundstep2, performedpathstep2]=mapmaker(sys1, spec1, environment1, realenvironment1, possiblesearchenabled, maxIteration, plotenabled,   offset, scale, video_name);
 
end