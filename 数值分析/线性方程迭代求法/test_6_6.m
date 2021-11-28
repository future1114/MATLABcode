clear all,close all
format long
%
%T=zeros(1,9999999);
% for i=1:9999999
    A=[-2.53119321763923,-0.0331188457689162,-0.0709649575423352;-4.42048444554312,3.33763562379000,2.18375878119889;-1.06642961129167,0.915657257278184,-3.04498745270765];
    b=[-3.46951598628394;4.62833096895301;-2.99402368179629];
       
        ts=input('��ѡ���������(J:Jacobi��G-S:Guass-Seidel��SOR�����ɳ�):','s'); TS=['J','G-S','SOR'];
        while ~ismember(ts,TS)
            disp('��������ȷ�ĵ���������')
            ts=input('��ѡ���������(J:Jacobi��G-S:Guass-Seidel��SOR�����ɳ�):','s');
        end
%     ts='J';
    
    N=length(b);
    xk=zeros(N,1);%������ʼֵ
    D=diag(diag(A));
    L=-tril(A,-1);%������
    U=-triu(A,1);%������
    if ts =='J'
        M=D;
    elseif ts =='G-S'
        M=D-L;
    else
        omiga=input('�������ɳ�����=');
        M=(D-omiga*L)/omiga;
    end
    B=M^(-1)*(M-A);
    f=M^(-1)*b;
    Rho=max(abs(eig(B)));
    % ������������װ뾶,�� Rho=max(abs(eig(B)))�� Rho=vrho(B);
    tic
    if Rho>=1
        fprintf('�װ뾶 Rho=%f>=1,%s ������������\n',Rho,ts)
    else
        max=1000;
        % max=input('����������������,n=');%�ﵽ����������������ֹͣ
        error=10^(-5);
        % error=input('���������,e=');%���ڽ�ľ���С�ڸ���ʱ����������
        usenorm=2;
        % usenorm=input('�����뷶�����ͣ�1,2,inf��')
        for k=1:max %����������
            xk1=B*xk+f; % ������ʽ
            Norm=norm(xk-xk1,usenorm);
            nk(k)=k;
            iterationxk(k,:)=xk1';
            normk(k)=Norm;
            if Norm<=error
                break;
            end
            xk=xk1;
        end
        table(uint16(nk'),iterationxk,normk') % matlab �߰汾��
        fprintf('������ľ�ȷ��Ϊ��');
         x=(inv(A)*b )'; %�⺯��������
        [m,n]=size(iterationxk);
        if norm(iterationxk(m,:)-iterationxk(m-1,:),usenorm)>error
            fprintf('��ע�⣺%s �������ĵ��������Ѿ��������������� n=%d!\n',ts,max)
        end
        
    end
    toc
    
%     T(1,i)=toc;
%     clearvars -except i T
%     
% end
% t=sum(T)/9999999