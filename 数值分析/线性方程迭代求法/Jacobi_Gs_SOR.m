clearvars -except A b
close all
format long
%% �ֶ�����
A=input('������ϵ������ A��A=');
b=input('�����볣���� b��b=');
%% ��������
% 1�����������������
%
% A=[-2.53119321763923,-0.0331188457689162,-0.0709649575423352;-4.42048444554312,3.33763562379000,2.18375878119889;-1.06642961129167,0.915657257278184,-3.04498745270765];
% b=[-3.46951598628394;4.62833096895301;-2.99402368179629];

A=[-3.98997849433770,0.890928625745769,3.18989912575377;-2.41075395398364,3.68439233264640,-0.550482458296239;0.537459024711985,4.46291702906506,2.94184911182297];
b=[2.31317215844629;-3.50074062919328;-0.793967981473040];

% A=[-1.81287714120605,2.15563897028514,-3.88250665765144;-2.77749165407443,2.38377561447117,3.30159471489712;-0.203625164261755,-0.764109815047471,4.02651788606604];
% b=[1.25165140369131;-2.90527244851318;0.894650109875066];

%% �Զ��������
nx = input('�����뷽����Ľ�����n = ');
A = single(zeros(nx,nx));
b = single(zeros(nx,1));
A = 10 * ( -5 + (5 + 5)*rand(nx,nx)) - 5 * ones(nx,nx);
b = 10 * ( -5 + (5 + 5)*rand(nx,1)) - 5 * ones(nx,1);
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

while Rho>=1
    fprintf('�װ뾶 Rho=%f>=1,%s ������������\n',Rho,ts)
    A = 10 * ( -5 + (5 + 5)*rand(nx,nx)) - 5 * ones(nx,nx);
    b = 10 * ( -5 + (5 + 5)*rand(nx,1)) - 5 * ones(nx,1);
    disp('�������� A �� b ')
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
        
        M=(D-omiga*L)/omiga;
    end
    B=M^(-1)*(M-A);
    f=M^(-1)*b;
    Rho=max(abs(eig(B)));
end

if ts =='SOR'
    disp('�Ƿ�ʹ����������ɳ��������۽����ɳ�����')
    songchi=input('����1��ʾʹ�ã�����2��ʾ��ʹ��');
    if songchi==1
        omiga=2/(1+(1-(Rho))^(1/2))
    end
end
if Rho>=1
    
    fprintf('�װ뾶 Rho=%f>=1,%s ������������\n',Rho,ts)
else
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
            pause(0.1)
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
            pause(0.1)
        end
    end
end