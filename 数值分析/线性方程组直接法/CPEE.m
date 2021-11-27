function [X, t]=CPEE(A,b)
% Column Principal Element Elimination
%����Ԫ��ȥ��
tic
B=[A b]; n=length(b); RA=rank(A);RB=rank(B);zhica=RB-RA;
if zhica>0
    disp('��ע�⣺��ΪRA~=RB�����Դ˷������޽�.')
    return
end
if RA==RB
    if RA==n
        disp('��ע�⣺��ΪRA=RB=n�����Դ˷�������Ψһ��.')
        X=zeros(n,1); C=zeros(1,n+1);
        % ��Ԫ
        for p= 1:n-1
            % ѡ��Ԫ
            [~,j]=max(abs(B(p:n,p))); C=B(p,:);
            B(p,:)= B(j+p-1,:); B(j+p-1,:)=C;
            % ��Ԫ
            for k=p+1:n
                m= B(k,p)/ B(p,p);
                B(k,p:n+1)= B(k,p:n+1)-m* B(p,p:n+1);
            end
        end
        % �ش�
        b=B(1:n,n+1);A=B(1:n,1:n); X(n)=b(n)/A(n,n);
        for q=n-1:-1:1
            X(q)=(b(q)-A(q,q+1:n)*X(q+1:n))/A(q,q);
        end
    else
        disp('��ע�⣺��ΪRA=RB<n�����Դ˷�������������.')
    end
    t=toc;
end
