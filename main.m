clear;
a=randi([1,100000],1,100);

% initialising matlabpool with 4 workers
matlabpool open 4

% initialising spmd tool to distribute jobs over 
% all 4 labs for parallel processing 
tic;
spmd
    % distributing inputs to each lab
	p=codistributed(a);
	P=getLocalPart(p);
	len=length(P);
    
	B=zeros(size(P));
    % calling radixSort() method to sort elements
    % and storing result from individual lab
    %into distributed array B
    B=radixSort(P);
end

% taking results from each lab
input1=B{1};    %lab 1
input2=B{2};    %lab 2
input3=B{3};    %lab 3
input4=B{4};    %lab 4
tot=toc;
matlabpool close

%creating a cell with all sorted arrays from each lab
cell={input1,input2,input3,input4};

%merging results from each lab
matlabpool(2)
tic;
spmd
    
    
    dcell=codistributed(cell);
    lcell=getLocalPart(dcell);

    i=1;
    j=1;
    k=1;
    while i<=length(lcell{1}) & j<=length(lcell{2})
        if(lcell{1}(i)<=lcell{2}(j))
            result(k)=lcell{1}(i);
            i=i+1;
        else
            result(k)=lcell{2}(j);
            j=j+1;
        end
        k=k+1;
    end
    while(i<=length(lcell{1}))
        result(k)=lcell{1}(i);
        i=i+1;
        k=k+1;
    end
    while(j<=length(lcell{2}))
        result(k)=lcell{2}(j);
        j=j+1;
        k=k+1;
    end
    %disp(result);
end


%merging(result{1},result{2});
result1=result{1};
result2=result{2};

tot=tot+toc;

matlabpool close

tic;

i=1;
j=1;
k=1;
while i<=length(result1) & j<=length(result2)
    if(result1(i)<=result2(j))
        fresult(k)=result1(i);
        i=i+1;
    else
        fresult(k)=result2(j);
        j=j+1;
    end
    k=k+1;
end
while(i<=length(result1))
    fresult(k)=result1(i);
    i=i+1;
    k=k+1;
end
while(j<=length(result2))
    fresult(k)=result2(j);
    j=j+1;
    k=k+1;
end

tot=tot+toc;
disp(tot);

%displaying resultant sorted array
%disp(fresult);

