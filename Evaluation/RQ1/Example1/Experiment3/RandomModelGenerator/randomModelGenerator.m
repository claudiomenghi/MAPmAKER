function [Models] =randomModelGenerator(numberOfInitialConfigurations, numberOfPartialInfoConfigurations, displayEnabled)
    close all;
    setVisualizationConstants;

    Models.numberOfInitialConfigurations=numberOfInitialConfigurations;
    Models.numberOfPartialInfoConfigurations=numberOfPartialInfoConfigurations;
    
    %% preparing the input for the experiments
    realenvironment=EnvironmentRoboCup();
    
    initRobot1=getRandomInitPosition(realenvironment);
    initRobot2=getRandomInitPosition(realenvironment);
    sys(1)=Robot1(realenvironment.map, realenvironment.pmap, initRobot1);
    sys(2)=Robot2(realenvironment.map, realenvironment.pmap, initRobot2);
    
    if(displayEnabled)
        grid = ones(realenvironment.x*scale+1,realenvironment.y*scale+1)*whitevalue;
        grid=visualizeGrid(grid, realenvironment);
        imshow(grid, c);
        grid = visualizeInit(sys, offset, scale, grid, realenvironment);
        grid =visualizeServices(sys, offset, scale, grid, realenvironment);
        input('type enter to see the partial maps');
    end

    for partialInfoNumber=1:numberOfPartialInfoConfigurations
        m.partialenvironment{partialInfoNumber}=PartialEnvironmentRoboCup();
        partialenvironment=m.partialenvironment{partialInfoNumber};
   
        R1=Robot1(partialenvironment.map, partialenvironment.pmap, 1);
        R2=Robot2(partialenvironment.map, partialenvironment.pmap, 1);
         
        [R1, R2]=addSync(R1,R2, 3,99,131);
        m.partialrobot1{partialInfoNumber}=R1;
        m.partialrobot2{partialInfoNumber}=R2;
    end        
    for initNumber=1:numberOfInitialConfigurations
        initRobot1Position=getRandomInitPosition(realenvironment);
        initRobot2Position=getRandomInitPosition(realenvironment);
        for partialInfoNumber=1:numberOfPartialInfoConfigurations
            partialenvironment=m.partialenvironment{partialInfoNumber};
            R1=m.partialrobot1{partialInfoNumber};
            R2=m.partialrobot2{partialInfoNumber};
            R1.init=initRobot1Position;
            R1.curr=initRobot1Position;
            
            R2.init=initRobot2Position;
            R2.curr=initRobot2Position;
            sys(1)=R1;
            sys(2)=R2;
            
            spec(1)=MissionRobot1(1, 2, 3,  1, 1, 1);
            spec(2)=MissionRobot2(4, 5,  2, 2);
            
            Models.sys{initNumber,partialInfoNumber}=sys;
            Models.spec{initNumber,partialInfoNumber}=spec;
            Models.realenvironment{initNumber,partialInfoNumber}=realenvironment;
            Models.partialenvironment{initNumber,partialInfoNumber}=partialenvironment;
            
            if(displayEnabled)
                grid = ones(partialenvironment.x*scale+1,partialenvironment.y*scale+1)*whitevalue;
                grid=visualizeGrid(grid, partialenvironment);
                imshow(grid, c);
                grid = visualizeInit(sys, offset, scale, grid, partialenvironment);
                grid =visualizeServices(sys, offset, scale, grid, partialenvironment);
                input('type enter to see the next map');
            end
        end
    end
end
