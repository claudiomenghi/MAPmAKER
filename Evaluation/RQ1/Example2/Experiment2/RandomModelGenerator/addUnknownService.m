function T = addUnknownService(T, location1, location2, location3)
        T.ser{location1}=1;
        T.pser{location1}=1;
        T.compser{location1}=1;
        T.ser{location2}=[];
        T.pser{location2}=1;
        T.compser{location2}=1;
        T.ser{location3}=[];
        T.pser{location3}=1;
        T.compser{location3}=[];
       
end