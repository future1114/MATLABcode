function [P,errory]=lagrangeinterpolationerror(X,Y,xi,M)
% 用途：Lagrange插值法数值求解；
% 格式：function [P,errory]=lagrangeinterpolationerror(X,Y,xi,M)
% X是插值节点向量，Y是插值节点上的函数值，xi是指定的自变量的值（可以多个），M是n+1阶导函数的绝对值在interval上的最大值。P插值多项式，y返回插值点处的函数值，errory是插值点处的误差。

m=length(X);
n=length(Y);
if m~=n,error('向量X与Y的长度必须一致');end
for k=1:m
    V=1;
    for j=1:m
        if k~=j
            V=conv(V,poly(X(j)))/((X(k)-X(j)));
        end
    end
    L1(k,:)=V;
end
P=Y*L1; %此处尤其注意多项式以向量形式存储，系数按降幂排列，输出的Language插值已经不是教材上的公式形式

omiga=1;
for j=1:m
    omiga=conv(omiga,poly(X(j)));
    
end
errorP=M*omiga/factorial(m);
errory=abs(polyval(errorP,xi));
 %y=vpa(polyval(P,x),6);
% errory=vpa(abs(polyval(errorP,xi)),6);