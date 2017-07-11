%inputs
close all;
% is an array that contains the mapping between the integer and the
% services. Position i contains the name of the service associated with the
% integer i
global actions;
actions={'recharge', 'r1loadbox1', 'r2loadbox1', 'r2unloadbox1', 'detectunloadingbox1', 'takeApicture'};


% contains the map of the environment
environment=EnvironmentMap();

% grid = ones(environment.x*scale+1,environment.y*scale+1)*whitevalue;
% hh=figure;
% grid=visualizeGrid(grid, environment);
% figure(); imshow(grid, c);
% xlabel('x'); ylabel('y');

sys(1)=Robot1(environment.map, environment.pmap);
sys(2)=Robot2(environment.map, environment.pmap);
%sys(3)=Robot3(environment.map, environment.pmap);

spec(1)=ExistenceGoal(1, 2, 1, 1);
%spec(1)=ExistenceGoal(1, 2, 1, [1,2]);
spec(2)=ExistenceGoal(3, 4, 2, 2);
%spec(2)=ResponseGoal(3, 4, [1, 2], [1,3]);
%spec(3)=ResponseGoal(5, 6, [2,3], 3);
robot1_ini=sys(1).init;
robot2_ini=sys(2).init;
fileID = fopen('data_record.txt','w');
fprintf(fileID,'-------------------------------\n');
fprintf(fileID,'Initial position of the robots:\n');
fprintf(fileID,'-------------------------------\n');
fprintf(fileID, 'Robot 1: %d \n', sys(1).init);
fprintf(fileID, 'Robot 2: %d \n', sys(2).init);
fprintf(fileID,'-------------------------------\n');
fprintf(fileID,'State of the doors:\n');
fprintf(fileID,'(1 means that the door is open for sure and 0 that exists an uncertainty)\n');
fprintf(fileID,'-------------------------------\n');
for i=1:length(environment.doors)
    fprintf(fileID,'Door from cell %d to cell %d: %d\n', environment.doors_pos(i,1), environment.doors_pos(i,2), environment.doors(i)); %'environment.doors(num2str(i))');
end
fclose(fileID);

