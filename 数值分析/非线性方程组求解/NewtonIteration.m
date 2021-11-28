function NewtonIteration(f,x0,error,max,s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f       函数
% x0      初值
% error   误差
% max     最大迭代次数
% s       方法
% s         s == 1 牛顿法
% s         s == 2 简化牛顿法
% s         s == 3 牛顿下山法
% s         s == 4 牛顿改进法1
% s         s == 5 牛顿改进法2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
syms x
df = diff(f,x);
% xfx 用于存放迭代次数、数值解、f(xk)、误差
xfx(1,1) = 0;
xfx(1,2) = x0;
xfx(1,3) = subs(f,x0);
if s==1
    disp('%%%%%%%%%%%%%%%')
    disp('牛顿法')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
elseif s==2
    disp('%%%%%%%%%%%%%%%')
    disp('简化牛顿法')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
elseif s==3
    disp('%%%%%%%%%%%%%%%')
    disp('牛顿下山法')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
elseif s==4
    disp('%%%%%%%%%%%%%%%')
    disp('牛顿改进法1')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
elseif s==5
    disp('%%%%%%%%%%%%%%%')
    disp('牛顿改进法2')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
end

% 迭代
for k = 1:max
    if s==1 | s==3
        subs(df,x0);
    end
    x1 = x0 - subs(f,x0) / c; % 注：此处 Xx1 也可直接用向量形式存放
    xfx(k + 1,1) = k;
    xfx(k + 1,2) = x1;
    xfx(k + 1,3) = subs(f,x1);
    xfx(k + 1,4) = abs(x1-x0);
    if abs(x1-x0) < error | abs((x1-x0) / x0) < error
        break
    else
        x0 = x1;
    end
    if s == 1
        c = subs(df,x0);
    elseif s == 3
        c = subs(df,x0);
        if abs(xfx(k,3)) < abs(xfx(k + 1,3))
            x0 = x0 * 0.5 + x1 * 0.5 ;
        end
    elseif s == 4
        c = subs(df,(x0+x1)/2);
    elseif s == 5
        c = (subs(df,x0) + subs(df,x0)) / 2;
    end
end
% double(xfx) % 低版本 MATLAB
table(uint16(xfx(:,1)),xfx(:,2:4)) % 高版本 MATLAB
if k == max
    sprintf('超过最大迭代次数%d',max)
end
sprintf('牛顿迭代法迭代了%d 次,数值解为%10.10f',k,double(x1))
toc
end