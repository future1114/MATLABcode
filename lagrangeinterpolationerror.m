function [P,errory]=lagrangeinterpolationerror(X,Y,xi,M)
% ��;��Lagrange��ֵ����ֵ��⣻
% ��ʽ��function [P,errory]=lagrangeinterpolationerror(X,Y,xi,M)
% X�ǲ�ֵ�ڵ�������Y�ǲ�ֵ�ڵ��ϵĺ���ֵ��xi��ָ�����Ա�����ֵ�����Զ������M��n+1�׵������ľ���ֵ��interval�ϵ����ֵ��P��ֵ����ʽ��y���ز�ֵ�㴦�ĺ���ֵ��errory�ǲ�ֵ�㴦����

m=length(X);
n=length(Y);
if m~=n,error('����X��Y�ĳ��ȱ���һ��');end
for k=1:m
    V=1;
    for j=1:m
        if k~=j
            V=conv(V,poly(X(j)))/((X(k)-X(j)));
        end
    end
    L1(k,:)=V;
end
P=Y*L1; %�˴�����ע�����ʽ��������ʽ�洢��ϵ�����������У������Language��ֵ�Ѿ����ǽ̲��ϵĹ�ʽ��ʽ

omiga=1;
for j=1:m
    omiga=conv(omiga,poly(X(j)));
    
end
errorP=M*omiga/factorial(m);
errory=abs(polyval(errorP,xi));
 %y=vpa(polyval(P,x),6);
% errory=vpa(abs(polyval(errorP,xi)),6);