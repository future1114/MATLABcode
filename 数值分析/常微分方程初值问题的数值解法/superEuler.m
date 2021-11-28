function S = superEuler(a, b, h, y11,f)
syms x y
n = (b-a)/h;
x0 = a;
x1 = a;
y0 = y11;
S(1,1) = x0;
S(2,1) = y0;
for m = 0:n-1
    x1 = x1 + h;
    f0 = subs(f,x,x0);
    f0 = subs(f0,y,y0);
    d = y0 + h*f0;
    f1 = d - 2*x1/d;
    y1 = y0 + h/2*(f0+f1);
    x0 = x1;
    y0 = y1;
    S(1, m+2) = x0;
    S(2, m+2) = y0;   
end
end