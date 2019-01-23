function E = EnvironmentMap()

E = RealEnvironmentMap();


% possible map
E.pmap=E.map;

%Random value for the uncertainty of the environment's doors
doors=ones(4,1);

for i=1:length(doors)
    
    doors(i,1)=round(rand());
    switch i
        case 1
            if doors(i,1) == 0
                E=addDoor(E, 5, 2, 6, 2); 
            end
        case 2
            if doors(i,1) == 0
                E=addDoor(E, 6, 2, 6, 3);
            end
        case 3
            if doors(i,1) == 0
                E=addDoor(E, 2, 6, 3, 6); 
            end
        case 4
            if doors(i,1) == 0
                E=addDoor(E, 2, 5, 2, 6); 
            end
    end
end

end

