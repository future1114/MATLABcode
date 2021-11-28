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
%% 欧拉
tic
E1 = Euler(a, b, h, Y1 , f);
toc
x1 = E1(1,:);
y1 = E1(2,:);
error1 = sum(abs(y1 - z));
%disp('欧拉法误差'),error1
sprintf('欧拉法误差%d',error1)
y1(2,:) = z;

tic
E2 = superEuler(a, b, h, Y1 , f);
toc
x2 = E2(1,:);
y2 = E2(2,:);
error2 = sum(abs(y2 - z));
%disp('改进欧拉法误差'),error2
sprintf('改进欧拉法误差%d',error1)
y2(2,:) = z;

%hold on
figure
plot(x1, y1);legend('欧拉法数值解','真实值')
figure
plot(x2, y2);legend('改进欧拉法数值解','真实值')
%hold off
%plot(x1,y1);legend('欧拉法数值解','改进欧拉法数值解','真实值') % 提前将y1与y2合成
%% Runge-Kutta
R1 = RungeKutta2(a, b, h, Y1 , f);
x3 = R1(1,:);
y3 = R1(2,:);
error3 = sum(abs(y3 - z));
sprintf('二阶龙格-库塔误差%d',error3)
y3(2,:) = z;
figure
plot(x3, y3);legend('二阶龙格库塔数值解','真实值')

R2 = RungeKutta31(a, b, h, Y1 , f);
x4 = R2(1,:);
y4 = R2(2,:);
error4 = sum(abs(y4 - z));
sprintf('三阶龙格-库塔误差%d',error4)
y4(2,:) = z;
figure
plot(x4, y4);legend('三阶龙格库塔数值解','真实值')
%%