classdef ArrayStorage < handle
    %ARRAYSTORAGE storage for all arrays, we are updating
    %             during the simulation
    
    properties
        
        % array with velocities at specific time
        velocities = zeros(1, 1000000);
        % array with heights at specific time
        heights = zeros(1, 1000000);
        % array with current time after start
        times = zeros(1, 1000000);
        % array with densities at specific time
        densities = zeros(1, 1000000);
        % array with pressures at specific time
        pressures = zeros(1, 1000000);
        % array with g-values at specific time
        g = zeros(1, 1000000);
        % array with resulting acceleration at specific time
        a = zeros(1, 1000000);
        % array with resulting uplift values at specific time / height
        uplifts = zeros(1, 1000000);
        %array with resulting uplift values at specific time / height
        F_Gravs = zeros(1, 1000000); %TODO: INTEGRATE LATER ON
        % array with cw-values for the cylinder
        cws = zeros(1, 1000000);
        %dynamic viscosity throughout simulation
        dynvis = zeros(1, 1000000);
        %ONLY FOR CLEMENS/ERIC
        bending_moments = zeros(1,1000000);
        
        %seed positions
        xArray = zeros(1, 1000000);
        yArray = zeros(1, 1000000);
        zArray = zeros(1, 1000000);
        
        %arrays with x - and y velocities to check
        xVelos = zeros(1,1000000);
        yVelos = zeros(1,1000000);
        
        %position information 
        xPos = zeros(1,1000000);
        yPos = zeros(1,1000000);
        
        %array with air temperatures
        air_temps = zeros(1, 1000000);
        %array with stagnation temperatures
        stag_temps = zeros(1, 1000000);
        
        %rotational velocities
        omegas = zeros(1, 1000000);
        torques = zeros(1, 1000000);
        
        %forces
        FWings = zeros(3, 1000000);
        Fstalls = zeros(1, 1000000);
        
        %viArrays
        vi = zeros(1, 1000000);
        %vi2 = zeros(100, 100000);
        %vi3 = zeros(100, 100000);
        %vi4 = zeros(100, 100000);
        
        %aero stuff
        %Res = zeros(1, 1000000);
        %phis = zeros(1, 1000000);
    end
    
    methods (Access = private)
        function obj = ArrayStorage
        end
    end
    methods (Static)
        function singleObj = getInstance
            persistent localObj
            if isempty(localObj) || ~isvalid(localObj)
                localObj = ArrayStorage;
            end
            singleObj = localObj;
        end
        function obj = cutOff(obj,counter)
            disp('CUTOFF')
            disp(counter)
            obj.times = obj.times(1:counter);
            obj.velocities = obj.velocities(1:counter);
            obj.heights = obj.heights(1:counter);
            obj.pressures = obj.pressures(1:counter);
            obj.densities = obj.densities(1:counter);
            obj.cws = obj.cws(1:counter);
            obj.dynvis = obj.dynvis(1:counter);
            obj.uplifts = obj.uplifts(1:counter);
            obj.F_Gravs = obj.F_Gravs(1:counter);
            obj.bending_moments = obj.bending_moments(1:counter);
            obj.a = obj.a(1:counter);
            obj.g = obj.g(1:counter);
            obj.xVelos = obj.xVelos(1:counter);
            obj.yVelos = obj.yVelos(1:counter);
            obj.xPos = obj.xPos(1:counter);
            obj.yPos = obj.yPos(1:counter);
            obj.air_temps = obj.air_temps(1:counter);
            obj.stag_temps = obj.stag_temps(1:counter);
            obj.omegas = obj.omegas(1:counter);
            obj.torques = obj.torques(1:counter);
           % obj.FWings = obj.FWings(3:counter);
            obj.Fstalls = obj.Fstalls(1:counter);
            
            obj.vi = obj.vi(1:counter);
           % obj.vi2 = obj.vi2(3:counter);
            %obj.vi3 = obj.vi3(3:counter);
            %obj.vi4 = obj.vi4(3:counter);
            
        end
    end
    methods
        function obj = append(obj, file)
            obj.times(file.globals.counter) = file.globals.currentTime;
            obj.velocities(file.globals.counter) = file.v.fall;
            obj.heights(file.globals.counter) = file.pos.z;
            obj.pressures(file.globals.counter) = file.atm.pressure;
            obj.densities(file.globals.counter) = file.atm.density;
            obj.dynvis(file.globals.counter) = file.atm.dyn_visc;
%            obj.cws(file.globals.counter) = file.aero.c_w;
%            obj.uplifts(file.globals.counter) = file.forces.F_res;
            %obj.F_Gravs(file.globals.counter) = file.forces.F_g;
            obj.bending_moments(file.globals.counter) = file.forces.M_bend;
            obj.a(file.globals.counter) = file.forces.az;
            obj.g(file.globals.counter) = file.forces.g;
            obj.xPos(file.globals.counter) = file.pos.x;
            obj.yPos(file.globals.counter) = file.pos.y;
            obj.air_temps(file.globals.counter) = file.atm.air_temp;
            obj.omegas(file.globals.counter) = file.v.omega;
            obj.torques(file.globals.counter) = file.forces.torque_Z;
            obj.FWings(:,file.globals.counter) = file.forces.F_res;
            obj.Fstalls(file.globals.counter) = file.forces.Fz_stall;
            
            obj.vi(file.globals.counter) = file.v.i;
           % obj.vi2(:,file.globals.counter) = file.wingArray(2).viArray;
           % obj.vi3(:,file.globals.counter) = file.wingArray(3).viArray;
           % obj.vi4(:,file.globals.counter) = file.wingArray(4).viArray;
            obj.xVelos(file.globals.counter) = file.v.trans_x;
            obj.yVelos(file.globals.counter) = file.v.trans_y;
            
        end
    end
end

