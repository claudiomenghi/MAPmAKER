function E = PartialEnvironmentPaper()

E = EnvironmentPaper();

%% possible map
E.pmap=E.map;

%Random value for the uncertainty of the environment's doors
doors=ones(6,1);

for i=1:length(doors)
    
    doors(i,1)=round(rand());
    switch i
        case 1
            if doors(i,1) == 0
                E=addDoor(E, 5, 2, 6, 2); 
            end
        case 2
            if doors(i,1) == 0
                E=addDoor(E, 3, 3, 3, 4); 
                E=addDoor(E, 3, 4, 3, 5);
            end
        case 3
            if doors(i,1) == 0
                E=addDoor(E, 5, 6, 6, 6); 
            end
        case 4
            if doors(i,1) == 0
                E=addDoor(E, 4, 8, 4, 8); 
            end
        case 5
            if doors(i,1) == 0
                E=addDoor(E, 4, 8, 4, 8); 
            end
        case 6
            if doors(i,1) == 0
                E=addDoor(E, 6, 9, 6, 9); 
            end

    end
end


    

end

