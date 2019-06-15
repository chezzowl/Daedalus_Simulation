classdef GOE < handle
    %GOE class storage for cw and ca values for the
    %GOE profile
    
    properties
        
        goe;
        
        alphas;
        ca;
        cw;
        
    end
    
    methods
        function obj = GOE()
            obj.goe = csvread('GOE.txt');
            obj.alphas = obj.goe(:,1);
            obj.ca = obj.goe(:,2);
            obj.cw = obj.goe(:,3);
        end
        
    end
end



