% the following function receives: 
% pos - Position object
% v - velocity object
% dens - density at this point

% and returns:
% x - value of the new position
% y - value of the new position
% z - value of the new position (which remains the same)
% new (absolute) seed velocity in x direction
% new (absolute) seed velocity in y direction

% force on centeral cylinder
function [ windRes ] = wind(windData, v, aero, atmo, globals)

%disp(windData.trueWindy)

%first: calculate relative velocity!
v.wind_x = windData.trueWindx - v.trans_x;
v.wind_y = windData.trueWindy - v.trans_y;

%calculate forces because of wind, taking the direction into account
Fx = (1/2)*v.wind_x*v.wind_x*atmo.density*aero.c_wSide*globals.sideFlowArea;
if(v.wind_x < 0)
Fx = -Fx;
end    
Fy = (1/2)*v.wind_y*v.wind_y*atmo.density*aero.c_wSide*globals.sideFlowArea;
if(v.wind_y < 0)
Fy = -Fy;
end 

windRes = [Fx, Fy];
end
