clear;
close all
format long;
syms f y x
f = y-2*x/y;
a = 0;
b = 1;
h = 0.1;
Y1 = 1;
z = [1, 1.0954, 1.1832, 1.2649, 1.3416, 1.4142, 1.4832, 1.5492, 1.6125, 1.6733, 1.7321];
%% ŷ��
tic
E1 = Euler(a, b, h, Y1 , f);
toc
x1 = E1(1,:);
y1 = E1(2,:);
error1 = sum(abs(y1 - z));
%disp('ŷ�������'),error1
sprintf('ŷ�������%d',error1)
y1(2,:) = z;

tic
E2 = superEuler(a, b, h, Y1 , f);
toc
x2 = E2(1,:);
y2 = E2(2,:);
error2 = sum(abs(y2 - z));
%disp('�Ľ�ŷ�������'),error2
sprintf('�Ľ�ŷ�������%d',error1)
y2(2,:) = z;

%hold on
figure
plot(x1, y1);legend('ŷ������ֵ��','��ʵֵ')
figure
plot(x2, y2);legend('�Ľ�ŷ������ֵ��','��ʵֵ')
%hold off
%plot(x1,y1);legend('ŷ������ֵ��','�Ľ�ŷ������ֵ��','��ʵֵ') % ��ǰ��y1��y2�ϳ�
%% Runge-Kutta
R1 = RungeKutta2(a, b, h, Y1 , f);
x3 = R1(1,:);
y3 = R1(2,:);
error3 = sum(abs(y3 - z));
sprintf('��������-�������%d',error3)
y3(2,:) = z;
figure
plot(x3, y3);legend('�������������ֵ��','��ʵֵ')

R2 = RungeKutta31(a, b, h, Y1 , f);
x4 = R2(1,:);
y4 = R2(2,:);
error4 = sum(abs(y4 - z));
sprintf('��������-�������%d',error4)
y4(2,:) = z;
figure
plot(x4, y4);legend('�������������ֵ��','��ʵֵ')
%%