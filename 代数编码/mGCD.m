function [result ,state] = mGCD(g,h)
% [q,r] = mGCD(x^7 + 2 * x^8 + 3 * x^7 + 4 * x^6 + 5 * x^5+ 6 * x^4+ 7 * x^3+ 8 * x^2+ 9 * x^1+ 10 , x^2 + 2 * x + 1)
m=0;n=1;
while ~isreal(h)&&h~=0
    [q,r] = quorem(g,h);
    t2=m-q*n;
    g=h;
    h=r;
    m=n;
    n=t2; 
end
result=n*(1/h);
state=1;
if h == 0
    state=0;
end
end

