function [R1, R2] = addUnknownSync(R1, R2, location1, location2, location3)

    R1.sync{location1} = 2;  % must sync with the robot with identifiers 2
    R1.psync{location1} = 2;  % must sync with the robot with identifiers 2
    R1.compsync{location1}=2;
    
    R1.psync{location2} =2;
    R1.sync{location2}=[]
    R1.compsync{location2}=[];
    
    R1.psync{location3} =2;
    R1.sync{location3} =[];
    R1.compsync{location3}=2;
    
    R2.sync{location1} = 1;  % must sync with the robot with identifiers 2
    R2.psync{location1} = 1;  % must sync with the robot with identifiers 2
    R2.compsync{location1}=1;

    R2.psync{location2} =1;
    R2.sync{location2} =[];
    R2.compsync{location2} =[];
    
    R2.psync{location3} =1;
    R2.sync{location3} =[];
    R2.compsync{location3}=1;
    
end