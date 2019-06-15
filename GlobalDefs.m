classdef GlobalDefs < handle
    %GLOBALDEFS storage class for all global variables
    
    %here, all the input values for one simulation shall be stored
    %this should be the only place to change values / code before
    %starting a propagation
    
    %TODO: ask mechanics team for moment of inertia!
    %TODO: make c function and everything else global
    
    properties
        
        %space seed values
        spaceSeedRadius = 0.035; %[m]
        wingLength = 0.20; %[m]
        rotorRoot;
        wingWidth = 0.05; %[m]
        spaceSeedHeight = 0.3071; %[m]
        bodyMass = 1.4; %[kg]
        currentTime = 0;
        counter = 1;
        
        %some values need to be set in the init function
        %after object is made
        spaceSeedArea; %in m^2
        sideFlowArea; %[m^2]
        rootArea; %[m^2]
        
        %variables that don't really belong here
%         theta = 5*pi/180; %[rad]   
        theta = 40*pi/180;
        % cw - value for the side - wind
        sideCW = 1.3;
        dt = 0.01; % time step in [s]
        inert_moment;
    end
    
    methods (Access = private)
        function obj = GlobalDefs
        end
    end
    methods (Static)
        function singleObj = getInstance
            persistent localObj
            if isempty(localObj) || ~isvalid(localObj)
                localObj = GlobalDefs;
            end
            singleObj = localObj;
            
        end
        function init(this)
            
            this.rootArea = pi * this.spaceSeedRadius^2;
            this.spaceSeedArea = pi * power(this.spaceSeedRadius + this.wingLength,2);
            this.sideFlowArea = this.spaceSeedRadius * this.spaceSeedHeight;
            this.inert_moment = 0.5*this.bodyMass*this.spaceSeedRadius^2;
            %transformation into radians for furhter calculation
            this.theta = this.theta;
            this.rotorRoot = this.spaceSeedRadius;
            
        end
    end
end
