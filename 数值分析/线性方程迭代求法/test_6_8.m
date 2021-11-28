clearvars -except A b
close all
format long

%% 自动生成随机
% nx = input('请输入方程组的阶数，n = ');
% A = single(zeros(nx,nx));
% b = single(zeros(nx,1));
% A = 10 * ( -5 + (5 + 5)*rand(nx,nx)) - 5 * ones(nx,nx);
% b = 10 * ( -5 + (5 + 5)*rand(nx,1)) - 5 * ones(nx,1);
%% 主函数
ts=input('请选择迭代方法(J:Jacobi，G-S:Guass-Seidel，SOR：超松弛):','s'); TS=['J','G-S','SOR'];
while ~ismember(ts,TS)
    disp('请输入正确的迭代方法！')
    ts=input('请选择迭代方法(J:Jacobi，G-S:Guass-Seidel，SOR：超松弛):','s');
end
N=length(b);
xk=zeros(N,1);%迭代初始值
D=diag(diag(A));
L=-tril(A,-1);%下三角
U=-triu(A,1);%上三角
if ts =='J'
    M=D;
elseif ts =='G-S'
    M=D-L;
else
    omiga=input('请输入松弛因子=');
    M=(D-omiga*L)/omiga;
end
B=M^(-1)*(M-A);
f=M^(-1)*b;
Rho=max(abs(eig(B)));
% 计算迭代矩阵谱半径,或 Rho=max(abs(eig(B)))或 Rho=vrho(B);
% tic
% while Rho<1
%     fprintf('谱半径 Rho=%f<1,%s 迭代法不收敛\n',Rho,ts)
%     disp('本次为显示不收敛情况')
%     A = 10 * ( -5 + (5 + 5)*rand(nx,nx)) - 5 * ones(nx,nx);
%     b = 10 * ( -5 + (5 + 5)*rand(nx,1)) - 5 * ones(nx,1);
%     disp('重新生成 A 和 b ')
%     N=length(b);
%     xk=zeros(N,1);%迭代初始值
%     D=diag(diag(A));
%     L=-tril(A,-1);%下三角
%     U=-triu(A,1);%上三角
%     if ts =='J'
%         M=D;
%     elseif ts =='G-S'
%         M=D-L;
%     else
%         M=(D-omiga*L)/omiga;
%     end
%     B=M^(-1)*(M-A);
%     f=M^(-1)*b;
%     Rho=max(abs(eig(B)));
% end
% toc

max=input('请输入最大迭代次数,n=');%达到最大迭代次数，迭代停止
error=input('请输入误差,e=');%相邻解的距离小于该数时，结束迭代
usenorm=input('请输入范数类型（1,2,inf）')
for k=1:max %最大迭代次数
    xk1=B*xk+f; % 迭代公式
    Norm=norm(xk-xk1,usenorm);
    nk(k)=k;
    iterationxk(k,:)=xk1';
    normk(k)=Norm;
    if Norm<=error
        break;
    end
    xk=xk1;
end
table(uint16(nk'),iterationxk,normk') % matlab 高版本用
fprintf('方程组的精确解为：');
x=(inv(A)*b )' %库函数计算结果
[m,n]=size(iterationxk);
if norm(iterationxk(m,:)-iterationxk(m-1,:),usenorm)>error
    fprintf('请注意：%s 迭代法的迭代次数已经超过最大迭代次数 n=%d!\n',ts,max)
end
% 如果是三阶方程组则作可视化
if n==3
    scatter3(x(1),x(2),x(3),'db');
    hold on
    piterationxk=[zeros(N,1)';iterationxk;x];
    for i=1:m+1
        pointx=piterationxk(i,1);
        pointy=piterationxk(i,2);
        pointz=piterationxk(i,3);
        scatter3(pointx,pointy,pointz,'*r')
        pause(0.5)
    end
    hold off
    figure,
    scatter3(x(1),x(2),x(3),'db'); hold on
    for j=1:m
        linex=[piterationxk(j,1),piterationxk(j+1,1)];
        liney=[piterationxk(j,2),piterationxk(j+1,2)];
        linez=[piterationxk(j,3),piterationxk(j+1,3)];
        plot3(linex,liney,linez,'*-')
        % axis([-1,15,-1,15,-1,15]);
        set(gca,'XTickLabel',[]);
        set(gca,'YTickLabel',[]);
        set(gca,'ZTickLabel',[]);
        grid on
        hold on
        pause(0.05)
    end
end
