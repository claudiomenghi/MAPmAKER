function [R1, R2] = addSync(R1, R2, location1, location2, location3)

    xmin=1;
    xmax=6;
    n=1;

    
    x=round(xmin+rand(1,n)*(xmax-xmin));
    switch x
        case 1
               [R1, R2]=addUnknownSync(R1, R2,location1,location2,location3);
        case 2
               [R1, R2]=addUnknownSync(R1, R2,location1,location3,location2);
        case 3
               [R1, R2]=addUnknownSync(R1, R2,location2,location1,location3);
        case 4
               [R1, R2]=addUnknownSync(R1, R2,location2,location3,location1);
        case 5
               [R1, R2]=addUnknownSync(R1, R2,location3,location1,location2);
        case 6
               [R1, R2]=addUnknownSync(R1, R2,location3,location2,location1);
    end
    
end