% method to implement radix sort

function array = radixSort(array)   

    maxx = max(array);
    base = 1;
while maxx/base > 0
    array = counting_sort(array,base);
    base = base * 10;
end

    % method implenting counting
    function W = counting_sort(array,base)
        X = zeros(1,11);
        W = zeros(1,numel(array));
        
        % Store count of occurrences in X()
        for j = 1:numel(array)
            X(rem(floor(array(j)/base),10)+1) = X(rem(floor(array(j)/base),10)+1) + 1;
        end
        
        % Change X(i) so that X(i) now contains actual
        % position of this digit in output array W()
        for i = 2:11
            X(i) = X(i) + X(i-1);
        end
        
        % Building output array W()
        for j = numel(array):-1:1
            W(X(rem(floor(array(j)/base),10)+1)) = array(j);
            X(rem(floor(array(j)/base),10)+1) = X(rem(floor(array(j)/base),10)+1) - 1;
        end
    end
end