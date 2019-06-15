function [output] = append( arg, array, counter )
%APPEND function for appending a set of values to a set of arrays
%of course those sets have to be of same size!

%inputs:
%       arg - argument to be put into array   
%       array - array, we add the argument to
%       counter - array position, at which all the values are placed 

disp(array);

if(size(array,2) < counter)
    warning('Allocation of new memory needed in append function!');
end

array(counter) = arg;
output = array;

end

