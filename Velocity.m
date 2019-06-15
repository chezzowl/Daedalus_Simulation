classdef Velocity < handle
    %VELOCITY Summary of obj class goes here
    %   Detailed explanation goes here
    
    properties
        
        omega; %rotational velocity
        i; % induced z-component
        fall;
        wind_x;
        wind_y;
        
        %translation velocity for whole seed, facing the wind
        trans_x;
        trans_y;
    end
    methods
        function obj = Velocity()
        obj.omega = 0;
%         obj.omega = 193; %TEST FOR STARTING POINT AT APPR. 19 KM (COUNTER = 24000)
        
        obj.i = 0;
%         obj.i = 17.1;
        obj.fall = 0;
%         obj.fall = 78.34;
        obj.wind_x = 0;
        obj.wind_y = 0;
        obj.trans_x = 0;
        obj.trans_y = 0;
        end    
    end
    
end

