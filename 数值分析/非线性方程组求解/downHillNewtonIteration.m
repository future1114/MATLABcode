function downHillNewtonIteration(f,x0,error,max)
syms x
df = diff(f,x);
% xfx ���ڴ�ŵ�����������ֵ�⡢f(xk)�����
xfx(1,1) = 0;
xfx(1,2) = x0;
xfx(1,3) = subs(f,x0);
% ����
for k = 1:max
    x1 = x0 - subs(f,x0) / subs(df,x0); % ע���˴� Xx1 Ҳ��ֱ����������ʽ���
    xfx(k + 1,1) = k;
    xfx(k + 1,2) = x1;
    xfx(k + 1,3) = subs(f,x1);
    xfx(k + 1,4) = abs(x1-x0);
    if abs(x1-x0) < error | abs((x1-x0) / x0) < error
        break
    else
        x0 = x1;
    end
    if abs(xfx(k,3)) < abs(xfx(k+1,3))
        x0 = x0 * 0.5 + x1 * 0.5 ;
    end
end
% double(xfx) % �Ͱ汾 MATLAB
table(uint16(xfx(:,1)),xfx(:,2:4)) % �߰汾 MATLAB
if k == max
    sprintf('��������������%d',max)
end
sprintf('ţ����ɽ��������������%d ��,��ֵ��Ϊ%10.10f',k,double(x1))