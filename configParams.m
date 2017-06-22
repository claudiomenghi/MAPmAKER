% set this flaf to 1 to enable the search of possible paths
global possibleengineenabled;
possibleengineenabled=1;

global robotFigEnabled;

% it is set by the algorithm whenever the search of the possible solution
% is triggered
global possibleSolutionSearchTriggered;
possibleSolutionSearchTriggered=0;
robotFigEnabled=0;

% horizon for the intersection automaton
h=3;
% horizon for the product
H=5;