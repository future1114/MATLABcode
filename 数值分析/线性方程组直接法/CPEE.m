function [X, t]=CPEE(A,b)
% Column Principal Element Elimination
%列主元消去法
tic
B=[A b]; n=length(b); RA=rank(A);RB=rank(B);zhica=RB-RA;
if zhica>0
    disp('请注意：因为RA~=RB，所以此方程组无解.')
    return
end
if RA==RB
    if RA==n
        disp('请注意：因为RA=RB=n，所以此方程组有唯一解.')
        X=zeros(n,1); C=zeros(1,n+1);
        % 消元
        for p= 1:n-1
            % 选主元
            [~,j]=max(abs(B(p:n,p))); C=B(p,:);
            B(p,:)= B(j+p-1,:); B(j+p-1,:)=C;
            % 消元
            for k=p+1:n
                m= B(k,p)/ B(p,p);
                B(k,p:n+1)= B(k,p:n+1)-m* B(p,p:n+1);
            end
        end
        % 回代
        b=B(1:n,n+1);A=B(1:n,1:n); X(n)=b(n)/A(n,n);
        for q=n-1:-1:1
            X(q)=(b(q)-A(q,q+1:n)*X(q+1:n))/A(q,q);
        end
    else
        disp('请注意：因为RA=RB<n，所以此方程组有无穷多解.')
    end
    t=toc;
end
