classdef Wings < handle
    %WINGS class representation of a single space seed wing
    
    properties
        
        angle; %angle with the god wing as reference, e.g. wing in positive y - direction
        bladeElements; %number of blade elements, into which we divide the wing
        dr;
        tdif; %thrust difference after an iteration
        %arrays for the equatorial(x) and perpendicular (z) force distributions
        %over the wing (length = nr. blade elements)
        forceDist_x; 
        forceDist_z;
        
    end
    
    methods
        %TODO:init
        function obj = Wings(angle, bEs, globals)
            
            obj.angle = angle;
            obj.bladeElements = bEs;
            obj.dr = globals.wingLength / bEs;
            obj.forceDist_x = zeros(1,bEs);
            obj.forceDist_z = zeros(1,bEs);
            obj.tdif = 0;
        end
        
    end
    
end

