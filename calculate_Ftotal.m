function [ F_x, F_y, F_z] = calculate_Ftotal( F_a, F_w )
%function, calculating the vector components of the total force on ONE wing

%inputs:
%   F_a: uplift vector
%   F_w: drag vector

%outputs:
%   F_x: x component 
%   F_y: y component
%   F_z: z component  

if(size(F_a) ~= 3 || size(F_w) ~= 3)
    fprintf('dimensions: \nF_w: %d \nF_a: %d', size(F_w),size(F_a));
end    

F_x = F_a(1) + F_w(1);
F_y = F_a(2) + F_w(2);
F_z = F_a(3) + F_w(3);

end

