function E = PartialEnvironmentPaper()

E = EnvironmentPaper();

%% possible map
E.pmap=E.map;

%Random value for the uncertainty of the environment's doors
doors=ones(3,1);

for i=1:length(doors)
    
    doors(i,1)=round(rand());
    switch i
        case 1
            if doors(i,1) == 0
                E=addDoor(E, 5, 2, 6, 2); 
                E=addDoor(E, 5, 3, 6, 3);
            end
        case 2
            if doors(i,1) == 0
                E=addDoor(E, 5, 5, 6, 5); 
                E=addDoor(E, 5, 6, 6, 6);
            end
        case 3
            if doors(i,1) == 0
                E=addDoor(E, 5, 9, 6, 9); 
                E=addDoor(E, 5, 10, 6, 10);
            end

    end
end


    

end

