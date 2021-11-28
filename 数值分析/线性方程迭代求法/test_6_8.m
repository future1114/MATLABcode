clearvars -except A b
close all
format long

%% �Զ��������
% nx = input('�����뷽����Ľ�����n = ');
% A = single(zeros(nx,nx));
% b = single(zeros(nx,1));
% A = 10 * ( -5 + (5 + 5)*rand(nx,nx)) - 5 * ones(nx,nx);
% b = 10 * ( -5 + (5 + 5)*rand(nx,1)) - 5 * ones(nx,1);
%% ������
ts=input('��ѡ���������(J:Jacobi��G-S:Guass-Seidel��SOR�����ɳ�):','s'); TS=['J','G-S','SOR'];
while ~ismember(ts,TS)
    disp('��������ȷ�ĵ���������')
    ts=input('��ѡ���������(J:Jacobi��G-S:Guass-Seidel��SOR�����ɳ�):','s');
end
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
% tic
% while Rho<1
%     fprintf('�װ뾶 Rho=%f<1,%s ������������\n',Rho,ts)
%     disp('����Ϊ��ʾ���������')
%     A = 10 * ( -5 + (5 + 5)*rand(nx,nx)) - 5 * ones(nx,nx);
%     b = 10 * ( -5 + (5 + 5)*rand(nx,1)) - 5 * ones(nx,1);
%     disp('�������� A �� b ')
%     N=length(b);
%     xk=zeros(N,1);%������ʼֵ
%     D=diag(diag(A));
%     L=-tril(A,-1);%������
%     U=-triu(A,1);%������
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

max=input('����������������,n=');%�ﵽ����������������ֹͣ
error=input('���������,e=');%���ڽ�ľ���С�ڸ���ʱ����������
usenorm=input('�����뷶�����ͣ�1,2,inf��')
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
x=(inv(A)*b )' %�⺯��������
[m,n]=size(iterationxk);
if norm(iterationxk(m,:)-iterationxk(m-1,:),usenorm)>error
    fprintf('��ע�⣺%s �������ĵ��������Ѿ��������������� n=%d!\n',ts,max)
end
% ��������׷������������ӻ�
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
