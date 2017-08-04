global whitevalue;
global blackvalue;
global redvalue;
global green;
global scale;
global c;
% contains the offset of the robot for visualization purposes
global offset;
global linewidth;
global customfontsize;
global legentactionperrow;
global robotcolors;

customfontsize=10;

legentactionperrow=5;
linewidth=0;

whitevalue=64;
blackvalue=57;
redvalue=44;
green=50;

scale = 30;

c=colorcube(64);

offset(1)=-5;
offset(2)=-5;
offset(3)=-5;

% sets the colors for the robots
robotcolors=[
    [1 0 1] %green 
    [0 0 1] % blue
    [1 0 0] % purple
    ];
