function [L, U]=L_U(A,b)
n = size(A,1);
L = zeros(n);
U = zeros(n);

for i=1:n
    U(1,n) = A(1,n);
    L(n,1) = A(n,1) / A(1,1);
end

for r = 1:n
    %ʽ3.2
    for i = 1:n
        temp = 0;
        if r~=1
            for k = 1:r-1
                temp = temp + L(r,k)*U(k,i);
            end
        end
        U(r,i) = A(r,i) - temp;
    end
    
    %ʽ3.3
    if r~=n
        for i = r+1:n
            temp = 0;
            for k=1:r-1
                temp = temp + L(i,k)*U(r,r);
            end
            L(i,r) = (b(i,1)-temp) / U(r,r);
        end
    end 
end


end