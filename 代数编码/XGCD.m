function [d,s,t]= XGCD(g,h)
% Àý:
% [d,s,t]= XGCD(x^3 + 2 * x^2 + 3 * x^1 + 4 , x^2 + 2 * x + 1)
s=1;t=0;r=g;
t1=1;s1=0;r1=h;
while ~isreal(r1) && r1~=0
    [q,r2] = quorem(r,r1);
    r = r1;
    s = s1;
    t = t1;
    r1 = r2;
    s1 = s-q*s1;
    t1 = t-q*s1;
end
c = sym2poly(r);
c = c(1,1);
d = r / c;
s = s / c;
t = t / c;
end
