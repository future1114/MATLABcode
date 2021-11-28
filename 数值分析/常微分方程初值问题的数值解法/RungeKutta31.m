function S = RungeKutta31(a, b, h, y1,f)
syms x y
n = (b-a)/h;
x0 = a;
x1 = a;
y0 = y1;
S(1,1) = x0;
S(2,1) = y0;
for m = 0:n-1
    x1 = x1 + h;
    K1 = fun(x0,y0);
    K2=fun(x0+h/2,y0+h/2*K1);
    K3=fun(x0+h,y0-h*K1+h*2*K2);
    y11 = y0 + h / 6 * (K1 + 4*K2 + K3);
    x0 = x1;
    y0 = y11;
    S(1, m+2) = x0;
    S(2, m+2) = y0;
end
end