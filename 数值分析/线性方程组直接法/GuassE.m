function [X, t]=GuassE(A,b)
% Gaussian Elimination
tic
B=[A b]; n=length(b); RA=rank(A);%��������; 
RB=rank(B);zhica=RB-RA;
if zhica>0
    disp('��ע�⣺��Ϊ RA~=RB�����Դ˷������޽�.')
    return
end
if RA==RB
    if RA==n
        disp('��ע�⣺��ΪRA=RB=n�����Դ˷�������Ψһ��') % ��Ԫ
        X=zeros(n,1);
        for p= 1:n-1
            for k=p+1:n
                m=B(k,p)/B(p,p);
                B(k,p:n+1)=B(k,p:n+1)-m* B(p,p:n+1);
            end
        end
        b=B(1:n,n+1);A=B(1:n,1:n); X(n)=b(n)/A(n,n);
        %�ش�w
        for q=n-1:-1:1
            X(q)=(b(q)-A(q,q+1:n)*X(q+1:n))/A(q,q);
        end
    else
        disp('��ע�⣺��ΪRA=RB<n�����Դ˷�������������.')
    end
    t=toc;
end