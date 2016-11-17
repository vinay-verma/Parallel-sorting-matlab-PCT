clear;
a=[36,15,17,102,54,72,43,39,10,1,222,76];
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
    %disp(B);
end
%disp('sorting done');
% taking results from each lab
spmd

    if labindex == 1
        labSend(B,2);
        labSend(B,3);
        labSend(B,4);
        G = cat(1,B,labReceive(2),labReceive(3),labReceive(4));
        %G(2)=labReceive(2);
        %G(3)=labReceive(3);
        %G(4)=labReceive(4);
    end
    
    if labindex == 2
        labSend(B,1);
        labSend(B,3)
        labSend(B,4)
        G = cat(1,labReceive(1),B,labReceive(3),labReceive(4));
        %G(1)=labReceive(1);
        %G(2)=B;
        %G(3)=labReceive(3);
        %G(4)=labReceive(4);
        
    end
    
    
    if labindex == 3
        labSend(B,1)
        labSend(B,2)
        labSend(B,4)
        G = cat(1,labReceive(1),labReceive(2),B,labReceive(4));
        %G(1)=labReceive(1);
        %G(2)=labReceive(2);
        %G(3)=B;
        %G(4)=labReceive(4);
    end
    
    if labindex == 4
        labSend(B,1)
        labSend(B,2)
        labSend(B,3)
        G = cat(1,labReceive(1),labReceive(2),labReceive(3),B);
        %G(1)=labReceive(1);
        %G(2)=labReceive(2);
        %G(3)=labReceive(3);
        %G(4)=B;
    end
    
end
spmd
    pos = zeros(size(B));
    for i=1:1:length(B)
        for(j=1:1:length(G))
            pos(i)= pos(i) + binarySearch(G(j,:),B(i));
        end
    end
end
posarray=[pos{1},pos{2},pos{3},pos{4}];
B = [B{1},B{2},B{3},B{4}];
for i=1:1:length(posarray)
    temp = posarray(i);
    sorted(temp) = B(i);
end
disp(sorted);
matlabpool close