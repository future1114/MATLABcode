% % 最小乘拟合/最佳平方逼近代码
% % 一、实验要求：
% % 基本要求：
% % 1. 根据算法找到算法与代码之间的对应关系，并实现代码；
% % 2. 根据所给的最佳平方逼近代码修改为最小二乘拟合代码，对下面数据选择合适的拟合曲线进行实现。
% % xi 1 2 3 4 5
% % fi 4 4.5 6 8 8.5
% % wi 2 1 3 1 1
% % 拓展要求：
% % 选择不同的离散函数，观察如何选用合适的函数进行拟合。 二、实验代码
% % 最佳平方逼近代码
% clear all
% close all
% interval=input('请输入区间端点的值(如：[-1 3]):');
% n=input('请输入节点个数');
% % 计算插值节点及相应插值节点的函数值
% X=interval(1):(interval(2)-interval(1))/(n-1):interval(2);
% syms x
% y=sin(x);
% Y=double(subs(y,x,X))
% Y=polyval(f,X);
%%
clear all
close all
% 求解任意次数的最佳平方逼近多项式。
format short
%% 计算系数矩阵及常数项
syms x G d fx %设置符号变量,x 为自变量，G 为 Grammer 矩阵，d 为系数向量
fx=sqrt(1+x^2); % 符号函数、函数句柄、子函数
interval=[0,1];
n=input('请输入逼近多项式的次数,n=')
% 此处可考虑添加权函数
% 构造 Grammar 矩阵及常数项 d
for i=1:n+1
    for j=1:n+1
        G(i,j)=int(x^(i-1)*x^(j-1),interval(1),interval(2));%int为求定积分
    end
    d(i)=int(fx*x^(i-1),interval(1),interval(2));
end
% 将 G、d 转成数值形式并解方程组以计算最佳平方逼近多项式的系数。注意：该多项式系数是升幂排列
%的，而 maltab 里多项式系数是降幂排列
G=subs(G);
d=subs(d);
a=d/G; % 或 a=G\d;
% 调换多项式系数，是指按降幂排列，有库函数的~~~
vector=n+1:-1:1;
disp('最佳平方逼近的多项式系数为（降幂）');
polycoefficient=double(a(vector))
%%最佳平方逼近误差
nthpoly=poly2sym(polycoefficient);
disp('最佳平方逼近误差');
 delta20=double(subs(int((fx-nthpoly)*(fx-nthpoly),interval(1),interval(2)))) % 直接定义运算
 delta21=double(subs(int(fx*fx,interval(1),interval(2))-a*d')) % 教材 P/68 公式 3.5
%% 画图
xx=interval(1):0.01:interval(2);
y1=double(subs(fx,xx));
y2=polyval(polycoefficient,xx);
plot(xx,y1,'-k',xx,y2,'-.r')

legend( 'f(x)',sprintf('f(x)的%d 次最佳平方逼近多项式',n))
 title(sprintf('f(x)及 %d 次最佳平方逼近多项式',n))
figure,plot(xx,y1-y2)
 title(sprintf('%d 次最佳平方逼近多项式的误差图',n))
