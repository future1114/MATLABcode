function downHillNewtonIteration(f,x0,error,max)
syms x
df = diff(f,x);
% xfx 用于存放迭代次数、数值解、f(xk)、误差
xfx(1,1) = 0;
xfx(1,2) = x0;
xfx(1,3) = subs(f,x0);
% 迭代
for k = 1:max
    x1 = x0 - subs(f,x0) / subs(df,x0); % 注：此处 Xx1 也可直接用向量形式存放
    xfx(k + 1,1) = k;
    xfx(k + 1,2) = x1;
    xfx(k + 1,3) = subs(f,x1);
    xfx(k + 1,4) = abs(x1-x0);
    if abs(x1-x0) < error | abs((x1-x0) / x0) < error
        break
    else
        x0 = x1;
    end
    if abs(xfx(k,3)) < abs(xfx(k+1,3))
        x0 = x0 * 0.5 + x1 * 0.5 ;
    end
end
% double(xfx) % 低版本 MATLAB
table(uint16(xfx(:,1)),xfx(:,2:4)) % 高版本 MATLAB
if k == max
    sprintf('超过最大迭代次数%d',max)
end
sprintf('牛顿下山法迭代法迭代了%d 次,数值解为%10.10f',k,double(x1))