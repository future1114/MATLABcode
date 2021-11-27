% *此文件为最小二乘拟合文件*
%
%_文件名为:LeastSquareFitting.m_ 
%%
clear all
close all
clc
%% 计算系数矩阵及常数项

syms x G d  %设置符号变量,x为自变量，G为Grammer矩阵，d为系数向量
[x,y] = simplefit_dataset;
sz=size(x);
disp('是否需要加权？')
disp('输入1，代表是，请输入权矩阵')
disp('输入2，代表否')
quan=input('请输入');

if quan==1
    sprintf('权矩阵大小为（1，%d ）',sz)
    omiga=input('输入权矩阵')
else
    omiga=ones(sz);
end

n=input('请输入逼近多项式的次数,n=')
%构造 Grammar 矩阵及常数项 d
for i=1:n+1
    for j=1:n+1
       G(i,j)=(omiga.*x.^(i-1))*x.^(j-1)';%书p74 式4.6
    end
   d(i)=(omiga.*y)*x.^(i-1)';
end
G=subs(G);
d=subs(d);
a=d/G; % 或 a=G\d;    % 调换多项式系数，是指按降幂排列（有库函数）
vector=n+1:-1:1;
disp('最小二乘法的多项式系数为（降幂）');
polycoefficient=double(a(vector))
nthpoly=poly2sym(polycoefficient);
 
%% 画图

x2=[0:0.01:10];
y2=polyval(polycoefficient,x2);

% [p s]=polyfit(x,y,n);
% normr1=s.normr

%% 画图1

% subplot(2,2,4)
hold on
plot(x,y,'.','Color','k')
plot(x2,y2,'LineWidth',1.5)
title(sprintf('f(x)及 %d 次最小二乘法多项式',n))
grid
hold off

%% 计算误差
wucha=0;
for i1=1:sz
    wucha = wucha + (omiga.*(polyval(polycoefficient,x)-y))*(polyval(polycoefficient,x)-y)';
end
disp('误差为：')
wucha
