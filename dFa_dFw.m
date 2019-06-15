%function [ dFx,dFy,dFz ] = dFa_dFw(file, r, wing, counter)
function [ dFx,dFy,dFz ] = dFa_dFw(file, r, wing)
%function, calculating the components of the resulting uplift on ONE wing
%returns dFx, dFy and dFz in the wings own coordinate system, this means
%dFy is always 0

%Inputs
%file:
%r: distance from rotation axis
%wing:
%counter: position in the wing's viArray, where we get the induced inflow

v_i = file.v.i;

% angle between resulting airflow and the wing plane 
phi = atan2( file.v.fall - v_i , (file.v.omega*r + cos(wing.angle) * file.v.wind_x + sin(wing.angle) * file.v.wind_y ) );

%%% TODO: horizontale und vertikale Geschwindigkeit in je eine Variable
%%% phi = atan2( file.v.fall - v_i , (file.v.omega*r + cos(wing.angle) * file.v.wind_x + sin(wing.angle) * file.v.wind_y ) );

% including the Prandtl tip loss factor (without calculating v_i)!
r_rel = r / (file.globals.wingLength + file.globals.rotorRoot);

%f - factor, with number of blades = 4
f = (4/2) * ( (1-r_rel)/(r_rel*abs(phi)));
%f = (4/2) * ( (1-r_rel)/(r_rel*phi));

%F - factor
F = (2/pi)*acos(exp(-f));

%resulting angle of attack
alpha = (phi - file.globals.theta)*180/pi;

%calculate Re - number
l = c_function(r);
vres = sqrt((file.v.fall - v_i)^2 + (file.v.omega*r + cos(wing.angle) * file.v.wind_x + sin(wing.angle) * file.v.wind_y )^2 ) ;
Re = (file.atm.density * l * vres)/file.atm.dyn_visc;

%TODO: if clauses for Re - number
if Re < 75000
    
    [ca, cw] = ca_cw(alpha, file.matrix50.table,Re);
    
elseif Re < 150000
    
    [ca, cw] = ca_cw(alpha, file.matrix100.table,Re);
    
else
    
    [ca, cw] = ca_cw(alpha, file.matrix200.table,Re);
    
end    
 %   [ca, cw] = ca_cw(alpha, file.matrix.table);
    
    %constant expression before vectors for F_a and F_w
    %now considering the tip loss factor!!
    constFa = 0.5*file.atm.density*ca*F;
    constFw = 0.5*file.atm.density*cw;
    vresSquared = ((file.v.omega*r + cos(wing.angle) * file.v.wind_x + sin(wing.angle) * file.v.wind_y)^2 + (file.v.fall - v_i)^2);%new - replaced file.v.i
    
    dr = file.globals.wingLength/wing.bladeElements;
    
    %uplift and drag in the wing coordinate system
    dFax = constFa * vresSquared*c_function(r)*(-sin(phi))*dr;
    dFay = 0;
    dFaz = constFa * vresSquared*c_function(r)*cos(phi)*dr ;
    
    dFwx = constFw * vresSquared*c_function(r)*cos(phi)*dr;
    dFwy = 0;
    dFwz = constFw * vresSquared*c_function(r)*sin(phi)*dr;
    
    %resulting force in the wing coordinate system     
    dFx = dFax + dFwx;
%     dFx = dFax - dFwx;%15.06.2019 - Sebastian's HOPEFULLY logical epiphany
    dFy = dFay + dFwy;
    dFz = dFaz + dFwz;
    
    if abs(alpha) > 16.5
        file.forces.Fz_stall = file.forces.Fz_stall + dFz;
    end    
end

