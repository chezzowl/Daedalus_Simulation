classdef Matrix
    %MATRIX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        table;
        
        alphas;
        ca;
        cw;
        
    end
    
    methods
        function obj = Matrix(filename)
            obj.table = csvread(filename);
            obj.alphas = obj.table(:,1);
            obj.ca = obj.table(:,2);
            obj.cw = obj.table(:,3);
        end
    end
    
end

