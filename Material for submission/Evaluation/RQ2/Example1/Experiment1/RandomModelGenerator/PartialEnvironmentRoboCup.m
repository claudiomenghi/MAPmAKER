function E = PartialEnvironmentRoboCup()

E = EnvironmentRoboCup();

%% possible map
E.pmap=E.map;

%Random value for the uncertainty of the environment's doors
doors=ones(5,1);

for i=1:length(doors)
    
    doors(i,1)=round(rand());
    switch i
        case 1
            if doors(i,1) == 0
                E=addDoor(E, 4, 2, 5, 2); 
                E=addDoor(E, 4, 4, 5, 4);
            end
        case 2
            if doors(i,1) == 0
                E=addDoor(E, 3, 5, 3, 6);
                E=addDoor(E, 1, 5, 1, 6);
            end
        case 3
            if doors(i,1) == 0
                E=addDoor(E, 4, 7, 5, 7); 
                E=addDoor(E, 5, 8, 5, 9);
            end
        case 4
            if doors(i,1) == 0
                E=addDoor(E, 8, 8, 8, 9); 
                E=addDoor(E, 12, 8, 12, 9);
            end
        case 5
            if doors(i,1) == 0
                E=addDoor(E, 6, 9, 7, 9); 
                E=addDoor(E, 6, 13, 7, 13); 
            end
    end
end


    

end

