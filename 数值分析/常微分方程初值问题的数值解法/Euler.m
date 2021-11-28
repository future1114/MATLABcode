function S = Euler(a, b, h, y1,f)
syms x y
n = (b-a)/h;
x0 = a;
x1 = a;
y0 = y1;
S(1,1) = x0;
S(2,1) = y0;
for m = 0:n-1
    x1 = x1 + h;
    f0 = subs(f,x,x0);
    f0 = subs(f0,y,y0);
    y11 = y0 + h*f0;
    x0 = x1;
    y0 = y11;
    S(1, m+2) = x0;
    S(2, m+2) = y0;
end
end