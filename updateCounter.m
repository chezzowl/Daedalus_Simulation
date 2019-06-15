%this function checks, whether the counter for the
%height array and the two wind value arrays have to be changed
%and returns the new value

function [windData] = updateCounter(windData,position)

% using the first wind entry for heights bigger than windData.HEIGHTS[1]
    if(position.z < 89500)
        
        % we have to omit the incrementation after currentCounter reaches
        % the end of the given arrays
        if(windData.counter < size(windData.HEIGHTS,1))
             % now we have to check, which entry of our arrays we need
             if(position.z < windData.HEIGHTS(windData.counter))
                 %% save current seed position for plots 
                 windData.crucialPositions(:,windData.counter) = [position.x;position.y;position.z];
                 %in case we are lower than the next height entry, we will need
                 %the data of the next entries
                 windData.counter = windData.counter + 1;
             end  
             %%
             windData.trueWindx = windData.XWINDS(windData.counter);
             windData.trueWindy = windData.YWINDS(windData.counter);
        end     
    end   
end