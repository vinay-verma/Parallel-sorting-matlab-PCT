
function result = Merge_sort2(input, p, r)
global A;

A = input;
if p < r
    q = floor((p+r)/2);
    Merge_sort2(A, p, q);
    Merge_sort2(A, q+1, r);
    Merge2(p, q, r);
end
result = A;
%disp(result);
end

function Merge2(p, q, r)
global A;
n1 = q - p + 1;
n2 = r - q;
L = [];
R = [];
for i = 1 : n1
    L(i) = A(p+i-1);
end

for j = 1 : n2
    R(j) = A(q+j);
end

L(n1+1) = inf;
R(n2+1) = inf;

i = 1;
j = 1;

for k = p : r
    if L(i) <= R(j)
        A(k) = L(i);
        i = i + 1;
    else
        A(k) = R(j);
        j = j + 1;
    end
end
end
