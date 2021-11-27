% *���ļ�Ϊ��С��������ļ�*
%
%_�ļ���Ϊ:LeastSquareFitting.m_ 
%%
clear all
close all
clc
%% ����ϵ�����󼰳�����

syms x G d  %���÷��ű���,xΪ�Ա�����GΪGrammer����dΪϵ������
[x,y] = simplefit_dataset;
sz=size(x);
disp('�Ƿ���Ҫ��Ȩ��')
disp('����1�������ǣ�������Ȩ����')
disp('����2�������')
quan=input('������');

if quan==1
    sprintf('Ȩ�����СΪ��1��%d ��',sz)
    omiga=input('����Ȩ����')
else
    omiga=ones(sz);
end

n=input('������ƽ�����ʽ�Ĵ���,n=')
%���� Grammar ���󼰳����� d
for i=1:n+1
    for j=1:n+1
       G(i,j)=(omiga.*x.^(i-1))*x.^(j-1)';%��p74 ʽ4.6
    end
   d(i)=(omiga.*y)*x.^(i-1)';
end
G=subs(G);
d=subs(d);
a=d/G; % �� a=G\d;    % ��������ʽϵ������ָ���������У��п⺯����
vector=n+1:-1:1;
disp('��С���˷��Ķ���ʽϵ��Ϊ�����ݣ�');
polycoefficient=double(a(vector))
nthpoly=poly2sym(polycoefficient);
 
%% ��ͼ

x2=[0:0.01:10];
y2=polyval(polycoefficient,x2);

% [p s]=polyfit(x,y,n);
% normr1=s.normr

%% ��ͼ1

% subplot(2,2,4)
hold on
plot(x,y,'.','Color','k')
plot(x2,y2,'LineWidth',1.5)
title(sprintf('f(x)�� %d ����С���˷�����ʽ',n))
grid
hold off

%% �������
wucha=0;
for i1=1:sz
    wucha = wucha + (omiga.*(polyval(polycoefficient,x)-y))*(polyval(polycoefficient,x)-y)';
end
disp('���Ϊ��')
wucha
