function [ res ] = fGesSeed(file)

%function [ Fx, Fy, Fz, torqueZ] = fGesSeed(file)
%FGESSEED function, calculating the resulting force
% in the seed coordinate system

%%%%%% TODO %%%%%%
% make seed - cs RIGHT HANDED!
%%%%%%%%%%%%%%%%%%

dr = file.wingArray(1).dr;

%for j = 1:1:2
    
    %reset temporary stall variable
    file.forces.Fz_stall = 0;
    
    Fx = 0;
    Fy = 0;
    Fz = 0;
    torqueZ = 0;
    
    %counter for v_i arrays
    counter = 1;
    
    %wing 1 : Fges_seed = Fges_wing
    for r = file.globals.rotorRoot: dr: file.globals.wingLength + file.globals.rotorRoot - dr
        
        [dFx,dFy,dFz] = dFa_dFw(file, r, file.wingArray(1));
%         Fx = Fx + dFx;
%         Fy = Fy + dFy;
%         Fz = Fz + dFz;
        
        torqueZ = torqueZ - dFx*r;
        %once upon a time, during the 762565th meeting of the simulation -
        %duo, the right hand rule appeared to Sebastian and told him, that
        %the x - component should be SUBTRACTED from the torque
        
        % to be continued...
        file.wingArray(1).forceDist_x(counter) = dFx;
        file.wingArray(1).forceDist_z(counter) = dFz;
        
        counter = counter + 1;
        
    end
    
    % transition from wing cs to seed cs!!
%     Fx = Fx + trapz(file.wingArray(1).forceDist_x);
    Fx = Fx - trapz(file.wingArray(1).forceDist_x);
    Fz = Fz + trapz(file.wingArray(1).forceDist_z);
    
    
    %reset counter
    counter = 1;
    
    %wing 2 : Fges_seed = [-Fy_wing, Fx_wing, Fz_wing]
    for r = file.globals.rotorRoot: dr: file.globals.wingLength + file.globals.rotorRoot - dr
        
        [dFx,dFy,dFz] = dFa_dFw(file, r, file.wingArray(2));
%         Fx = Fx - dFy;
%         Fy = Fy + dFx;
%         Fz = Fz + dFz;
        
        torqueZ = torqueZ - dFx*r;
        
        file.wingArray(2).forceDist_x(counter) = dFx;
        file.wingArray(2).forceDist_z(counter) = dFz;
        counter = counter + 1;
    end
    
%     Fy = Fy + trapz(file.wingArray(2).forceDist_x);
    Fy = Fy - trapz(file.wingArray(2).forceDist_x);
    Fz = Fz + trapz(file.wingArray(2).forceDist_z);
    
    %reset counter
    counter = 1;
    
    %wing 3 : Fges_seed = [-1, -1, 1] * Fges_wing
    for r = file.globals.rotorRoot: dr: file.globals.wingLength + file.globals.rotorRoot - dr
        
        [dFx,dFy,dFz] = dFa_dFw(file, r, file.wingArray(3));
%         Fx = Fx - dFx;
%         Fy = Fy - dFy;
%         Fz = Fz + dFz;
        
        torqueZ = torqueZ - dFx*r;
        
        file.wingArray(3).forceDist_x(counter) = dFx;
        file.wingArray(3).forceDist_z(counter) = dFz;
        counter = counter + 1;
    end
    
%     Fx = Fx - trapz(file.wingArray(3).forceDist_x);
    Fx = Fx + trapz(file.wingArray(3).forceDist_x);
    Fz = Fz + trapz(file.wingArray(3).forceDist_z);
    
    %reset counter
    counter = 1;
    
    %wing 4 : Fges_seed = [Fy_wing, -Fx_wing, Fz_wing]
    for r = file.globals.rotorRoot: dr: file.globals.wingLength + file.globals.rotorRoot - dr
        
        [dFx,dFy,dFz] = dFa_dFw(file, r, file.wingArray(4));
%         Fx = Fx + dFy;
%         Fy = Fy - dFx;
%         Fz = Fz + dFz;
        
        torqueZ = torqueZ - dFx*r;
        
        file.wingArray(4).forceDist_x(counter) = dFx;
        file.wingArray(4).forceDist_z(counter) = dFz;
        
        counter = counter + 1;
    end
    
%     Fy = Fy - trapz(file.wingArray(4).forceDist_x);
    Fy = Fy + trapz(file.wingArray(4).forceDist_x);
    Fz = Fz + trapz(file.wingArray(4).forceDist_z);
    
    %file.v.i = sqrt(abs(Fz) / (2*file.atm.density*file.globals.spaceSeedArea))*sign(Fz);
    
%end

res = [Fx, Fy, Fz, torqueZ];

end