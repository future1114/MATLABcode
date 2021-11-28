clear all,close all
format long
%
%T=zeros(1,9999999);
% for i=1:9999999
    A=[-2.53119321763923,-0.0331188457689162,-0.0709649575423352;-4.42048444554312,3.33763562379000,2.18375878119889;-1.06642961129167,0.915657257278184,-3.04498745270765];
    b=[-3.46951598628394;4.62833096895301;-2.99402368179629];
       
        ts=input('请选择迭代方法(J:Jacobi，G-S:Guass-Seidel，SOR：超松弛):','s'); TS=['J','G-S','SOR'];
        while ~ismember(ts,TS)
            disp('请输入正确的迭代方法！')
            ts=input('请选择迭代方法(J:Jacobi，G-S:Guass-Seidel，SOR：超松弛):','s');
        end
%     ts='J';
    
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
    tic
    if Rho>=1
        fprintf('谱半径 Rho=%f>=1,%s 迭代法不收敛\n',Rho,ts)
    else
        max=1000;
        % max=input('请输入最大迭代次数,n=');%达到最大迭代次数，迭代停止
        error=10^(-5);
        % error=input('请输入误差,e=');%相邻解的距离小于该数时，结束迭代
        usenorm=2;
        % usenorm=input('请输入范数类型（1,2,inf）')
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
         x=(inv(A)*b )'; %库函数计算结果
        [m,n]=size(iterationxk);
        if norm(iterationxk(m,:)-iterationxk(m-1,:),usenorm)>error
            fprintf('请注意：%s 迭代法的迭代次数已经超过最大迭代次数 n=%d!\n',ts,max)
        end
        
    end
    toc
    
%     T(1,i)=toc;
%     clearvars -except i T
%     
% end
% t=sum(T)/9999999