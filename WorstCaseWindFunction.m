%function for updating our new position, considering
% only the worst case, e.g. a scenario, where we instantly have
% the speed of the wind in x - / y - direction
function [xNew, yNew, zNew, v_x, v_y] = WorstCaseWindFunction(xWind,yWind, xPositionOld, yPositionOld, zPositionOld)

%global sideFlowArea;
global dt;
%global bodyMass;
%global sideCW;

%here we say, that our wind velocity is also our velocity in x - / y -
%direction

v_x = xWind;
v_y = yWind;

%calculate the position deviation because of the wind
deltaX = v_x * dt;
deltaY = v_y * dt;

xNew = xPositionOld + deltaX;
yNew = yPositionOld + deltaY;
zNew = zPositionOld;


end
