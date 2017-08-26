function init = getRandomInitPosition(environment)

    occupied=environment.occupied;
    while (1)
        valid=1;
        init = round(1 + (environment.x*environment.y - 1).*rand);
        for i=1:length(occupied)
            if init==occupied(i)
                msg=['The initial position ', num2str(init), ' is not valid.'];
                %disp(msg)
                valid=0;
                break;
            end
        end
        if valid==1
            break;
        end  
    end
    
end