clear all
file = initFile();
%thetaConfirmation = file.globals.theta;
bendingCW = 1.8;
height = file.pos.z;

Fwind = [0, 0]; %force, generated only by wind on seed body
Fres = [0, 0, 0, 0]; %force, generated only by rotor
torque = 0;

iterating = true; % boolean, indicating whether we calculate vi by iteration or
% with the hover velocity formula

%const_vi = sqrt((file.globals.bodyMass*9.81) / (2*file.refs.Density_0*file.globals.spaceSeedArea));
%const_vi = 127.4501; %[m/s]

%Sebastian had a great idea
%file.v.omega = 10000; 

while height > 0
 
    % updating variables
    file.atm.density = file.refs.Density_0 * exp (-file.pos.z/8400);
    file.atm.pressure = file.refs.Pressure_0 * exp (-file.pos.z/file.refs.h_0);
    p = atmoscoesa(height, 'None'); %for temperature
    file.atm.air_temp = p;
    file.atm.dyn_visc = 0.000001458 * ( file.atm.air_temp^(1.5) / (file.atm.air_temp + 110.4));
    
    file.forces.g = 9.81 * power(6370000/(6370000 + file.pos.z), 2);
    file.forces.F_body = 0.5*file.v.fall*file.v.fall * file.globals.rootArea * file.aero.c_wSeedBody*file.atm.density;
    
    % wind stuff
    updateCounter(file.windData, file.pos);
    Fwind = wind(file.windData, file.v, file.aero,file.atm,file.globals);
    
    % decide, whether or not we will iterate
    if iterating == true
        iterationLimit = 3;
        %try with one iteration under 35 km
        if height < 35000
            iterationLimit = 1;
        end
    else
        iterationLimit = 1;
    end
    
    %resulting force, still with torque!
    for j = 1:1:iterationLimit
        Fres = fGesSeed(file);
        
        if iterating == true
            
            oldvi = file.v.i;
            file.v.i = sqrt(abs(Fres(3)) / (2*file.atm.density*file.globals.spaceSeedArea))*sign(Fres(3)); % Fres(3) = Fz
            %v.s
%             if abs(oldvi - file.v.i)/file.v.i > 0.1 && file.globals.counter > 1000000  % otherwise, it fucks up after the first step
%                 iterating = false;
%                 file.v.i = sqrt((file.globals.bodyMass*file.forces.g) / (2*file.atm.density*file.globals.spaceSeedArea));
%                 disp(file.globals.counter)
%             end
            
        else
            file.v.i = sqrt((file.globals.bodyMass*file.forces.g) / (2*file.atm.density*file.globals.spaceSeedArea));
        end
        
    end
    
    %separate torque and Fres
    torque = Fres(4);
    file.forces.torque_Z = torque;
    Fres = Fres(1:3);
    file.forces.F_res = Fres;
    
    file.forces.az = file.forces.g - (file.forces.F_body/file.globals.bodyMass) - (Fres(3)/file.globals.bodyMass); %new
    
    %now finally velocity and height
    file.v.omega = file.v.omega + (torque/file.globals.inert_moment)*file.globals.dt;
    file.v.fall = file.v.fall + file.forces.az*file.globals.dt;
    file.pos.z = file.pos.z - file.v.fall*file.globals.dt;
    machNum = file.v.fall / file.refs.machCoeff;
    
    %translational speeds
    file.v.trans_x = file.v.trans_x + (Fres(1) + Fwind(1))/ file.globals.bodyMass;
    file.v.trans_y = file.v.trans_y + (Fres(2) + Fwind(2))/ file.globals.bodyMass;
    
    %position update
    file.pos.x = (((Fres(1) + Fwind(1))/ file.globals.bodyMass )/2 ) * file.globals.dt^2 + file.v.trans_x * file.globals.dt + file.pos.x;
    file.pos.y = (((Fres(2) + Fwind(2))/ file.globals.bodyMass )/2 ) * file.globals.dt^2 + file.v.trans_y * file.globals.dt + file.pos.y;
    
    %file.aero.c_w = 0.0181*power(machNum,6) - 0.2206*power(machNum,5) + 1.0374*power(machNum,4) - 2.3135*power(machNum,3) + 2.2951*power(machNum,2) - 0.5539*machNum + 0.4411;
    
    %   this one is better but for folded wings
    %   uncomment the following line for a c_w calculation for folded wings!
    file.aero.c_wSeedBody = 0.0163*power(machNum,6) - 0.2012*power(machNum,5) + 0.9576*power(machNum,4) - 2.1343*power(machNum,3) + 1.9871*power(machNum,2) - 0.0657*machNum + 0.3482;
    
    file.forces.M_bend = 0.5*file.atm.density*bendingCW*file.v.fall*file.v.fall*0.5*file.globals.wingWidth*file.globals.wingLength*file.globals.wingLength;
    
    file.arrays.append(file);
    
    file.globals.currentTime = file.globals.currentTime + file.globals.dt;
    file.globals.counter = file.globals.counter + 1;
    
    height = file.pos.z;
    
end

file.globals.counter = file.globals.counter - 1;

file.arrays.cutOff(file.arrays, file.globals.counter);

%plot positions in the end
plot(file.arrays.times,file.arrays.heights), xlabel('time'),ylabel('height');
plot3(file.arrays.xPos, file.arrays.yPos, file.arrays.heights), xlabel('x'),ylabel('y'),zlabel('height');

