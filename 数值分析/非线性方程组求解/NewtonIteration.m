function NewtonIteration(f,x0,error,max,s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f       ����
% x0      ��ֵ
% error   ���
% max     ����������
% s       ����
% s         s == 1 ţ�ٷ�
% s         s == 2 ��ţ�ٷ�
% s         s == 3 ţ����ɽ��
% s         s == 4 ţ�ٸĽ���1
% s         s == 5 ţ�ٸĽ���2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
syms x
df = diff(f,x);
% xfx ���ڴ�ŵ�����������ֵ�⡢f(xk)�����
xfx(1,1) = 0;
xfx(1,2) = x0;
xfx(1,3) = subs(f,x0);
if s==1
    disp('%%%%%%%%%%%%%%%')
    disp('ţ�ٷ�')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
elseif s==2
    disp('%%%%%%%%%%%%%%%')
    disp('��ţ�ٷ�')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
elseif s==3
    disp('%%%%%%%%%%%%%%%')
    disp('ţ����ɽ��')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
elseif s==4
    disp('%%%%%%%%%%%%%%%')
    disp('ţ�ٸĽ���1')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
elseif s==5
    disp('%%%%%%%%%%%%%%%')
    disp('ţ�ٸĽ���2')
    c = subs(df,x0);
    disp('%%%%%%%%%%%%%%%')
end

% ����
for k = 1:max
    if s==1 | s==3
        subs(df,x0);
    end
    x1 = x0 - subs(f,x0) / c; % ע���˴� Xx1 Ҳ��ֱ����������ʽ���
    xfx(k + 1,1) = k;
    xfx(k + 1,2) = x1;
    xfx(k + 1,3) = subs(f,x1);
    xfx(k + 1,4) = abs(x1-x0);
    if abs(x1-x0) < error | abs((x1-x0) / x0) < error
        break
    else
        x0 = x1;
    end
    if s == 1
        c = subs(df,x0);
    elseif s == 3
        c = subs(df,x0);
        if abs(xfx(k,3)) < abs(xfx(k + 1,3))
            x0 = x0 * 0.5 + x1 * 0.5 ;
        end
    elseif s == 4
        c = subs(df,(x0+x1)/2);
    elseif s == 5
        c = (subs(df,x0) + subs(df,x0)) / 2;
    end
end
% double(xfx) % �Ͱ汾 MATLAB
table(uint16(xfx(:,1)),xfx(:,2:4)) % �߰汾 MATLAB
if k == max
    sprintf('��������������%d',max)
end
sprintf('ţ�ٵ�����������%d ��,��ֵ��Ϊ%10.10f',k,double(x1))
toc
end