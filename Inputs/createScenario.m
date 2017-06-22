%inputs

% is an array that contains the mapping between the integer and the
% services. Position i contains the name of the service associated with the
% integer i
global actions;
actions={'recharge', 'r1loadbox1', 'r2loadbox1', 'r2unloadbox1', 'detectunloadingbox1', 'takeApicture'};


% contains the map of the environment
environment=EnvironmentMap();


sys(1)=Robot1(environment.map, environment.pmap);
%sys(2)=Robot2(environment.map, environment.pmap);
%sys(3)=Robot3(environment.map, environment.pmap);

spec(1)=ExistenceGoal(1, 2, 1, 1);
%spec(1)=ExistenceGoal(1, 2, 1, [1,2]);
%spec(2)=ResponseGoal(3, 4, [1, 2], [1,3]);
%spec(3)=ResponseGoal(5, 6, [2,3], 3);

