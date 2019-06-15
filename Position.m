classdef Position < handle
    %POSITION class storing current and previous positions
    
    % the current x, y and z position during propagation are
    % stored in x, y and z
    %to put them into the array storages, the update function has to be
    %called! 
    %Otherwise you lose the values after they are overwritten 
    %at the next time step.
    
    %important: (0, 0 ,0) is our starting point!
    
    properties
        
        x; % x value
        y; % y value
        z; % z value
        
        %last values, needed for the wind function
        %xOld = 0;
        %yOld = 0;
        %zOld = 90000;
        
    end
    
    methods    
        function obj = Position (x,y,z)
            obj.x = x;
            obj.y = y;
            obj.z = z;
            
            disp(z);
        end    
    end
    
end

