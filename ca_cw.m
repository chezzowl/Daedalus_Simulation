function[ca, cw] = ca_cw(alpha, matrix, Re)
%TODO

if(alpha > 8 || alpha < -6)  %estimated stall value from GOE - matrices
    
    %ca = max(matrix(:,2))*sin(alpha * (pi/180));
    
    cw = 1.2*sin(alpha * (pi/180));
    ca = 1.9*sin(alpha * (pi/180))*cos(alpha* (pi/180)); %Fecher Mail from 07.08
    
    cw = min(cw, 1.2);
    
    %only for NACA at RE 50000 the table is used until alpha = 11deg
    if (alpha < 11 && alpha > 8 && Re < 75000)
        i = 1;
        while matrix(i,1) > alpha
            
            i = i + 1;
            
        end
        
        ca = matrix(i,2);
        cw = matrix(i,3);
        
    end
else
    i = 1;
    while matrix(i,1) > alpha
        
        i = i + 1;
        
    end
    
    ca = matrix(i,2);
    cw = matrix(i,3);
    
    
end


end

