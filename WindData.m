classdef WindData < handle
    %WINDDATA Storage for the wind arrays we load
    %from the files, given to us
    
    properties
        
        %HEIGHTS = csvread('hoehen.txt');
        %XWINDS = csvread('xWerte.txt');
        %YWINDS = csvread('yWerte.txt');
        
        HEIGHTS = csvread('flugtagdaten\Hkomma.csv');
        XWINDS = csvread('flugtagdaten\Xkomma.csv');
        YWINDS = csvread('flugtagdaten\Ykomma.csv');
        
        %positions along the global z-axis at which
        %wind data gets updated
%         x = size(csvread('flugtagdaten\Hkomma.csv'));
        crucialPositions = zeros(3,size(csvread('flugtagdaten\Hkomma.csv'),1));
%         crucialPos_y = zeros(size(csvread('flugtagdaten\Hkomma.csv')));
%         cruci
        
        counter = 1; %current array entry, we are looking at
        
        trueWindx = 0;
        trueWindy = 0;
    end
    
    methods 
    end
    
end

