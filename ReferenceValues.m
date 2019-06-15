classdef ReferenceValues
    %REFERENCEVALUES set of reference values we need for
    %the simulation
    
    properties
        Density_0 = 1.293; % at 0 °C
        Pressure_0 = 101325;
        h_0 = 8000;
        machCoeff = 343; %[m/s] to get mach number
        cp2  = 2010; % doubled constant of the specific heat [J / kg*K]
    end
    
    methods
    end
    
end

