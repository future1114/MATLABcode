function [q,r]=DaiYuChuFa(b,a)
% q����
% r����
% b/a
[mb,nb] = size(b);
nb = max(mb,nb);
na = length(a);
if na > nb
   q = zeros(superiorfloat(b,a));
   r = cast(b,class(q));%class ���� obj ��������ơ�
   %cast ������ת��Ϊ��ͬ����������
else
   [q,zf] = filter(b, a, [1 zeros(1,nb-na)]);%1ά�����˲���,��� x Ϊ�������� filter ���˲��������Դ�С�� x ��ͬ��������ʽ���ء�
   if mb ~= 1
      q = q(:);
   end
   if nargout > 1
      r = zeros(size(b),class(q));
      lq = length(q);
      r(lq+1:end) = a(1)*zf(1:nb-lq);
   end
end
