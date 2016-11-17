function mid = binarySearch(list,value)
       
    low = 1;
    high = numel(list);
    %disp(list);
    while( low <= high )
        mid = floor((low + high)/2);
            % disp(high);
        
        if( list(mid) > value )
            high = mid - 1;
        elseif( list(mid) < value )
        	low = mid + 1;
        else
            return
        end
    end
        if( list(mid) > value)
            mid = mid - 1;
        return
 
end