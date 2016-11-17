function countSort(arr,exp)
    output=zeros(size(arr));
    count=[0,0,0,0,0,0,0,0,0,0];
    %store count of occurences in count()
    value=length(arr);
    for i=1:1:value
        index=mod(floor(arr(i)/exp),10)+1;
        count(index)=count(index)+1;
    end
    
    %change count(i) so that count(i) now contains
    %actual position of this digit in output
    for i=2:1:10
        count(i)=count(i)+count(i-1);
    end
  
    
    %build output array
    i=length(arr);
    while(i>=1)
        index=mod(floor(arr(i)/exp),10)+1;
        output(count(index))=arr(i);
        count(index)=count(index)-1;
        i=i-1;
    end
    
    
    %copy the output array to final, so that arr() now
    %contains sorted numbers according to current digit
    value=length(arr);
    for i=1:1:value
        arr(i)=output(i);
    end