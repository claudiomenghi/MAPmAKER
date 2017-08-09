function E = PartialEnvironmentPaper()

E = EnvironmentPaper();

%% possible map
E.pmap=E.map;

%Random value for the uncertainty of the environment's doors
doors=ones(1,6);

for i=1:6
    
    doors(1,i)=round(rand());
    switch i
        case 1
            if doors(1,i) == 0
                E=addDoor(E, 5, 2, 6, 2); 
            end
        case 2
            if doors(1,i) == 0
                E=addDoor(E, 1, 3, 1, 4); 
                E=addDoor(E, 1, 4, 1, 5);
            end
        case 3
            if doors(1,i) == 0
                E=addDoor(E, 5, 6, 6, 6); 
            end
        case 4
            if doors(1,i) == 0
                E=addDoor(E, 4, 8, 4, 9); 
            end
        case 5
            if doors(1,i) == 0
                E=addDoor(E, 4, 8, 4, 9); 
            end
        case 6
            if doors(1,i) == 0
                E=addDoor(E, 5, 9, 6, 9); 
            end

    end
end


    

end

