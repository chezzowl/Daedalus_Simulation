classdef Forces < handle
    %FORCES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        F_x = 0;
        F_y = 0;
        F_z = 0;
        
        torque_Z = 0;
        M_bend = 0;
        
        F_res = 0; % resulting force for whole seed 
        F_body = 0;
        
        g = 9.81;
        az = 0;
        
        %for testing reasons
        Fz_stall = 0;
    end
    
    methods
    end
    
end

