function [q,r]=DaiYuChuFa(b,a)
% q：商
% r：余
% b/a
[mb,nb] = size(b);
nb = max(mb,nb);
na = length(a);
if na > nb
   q = zeros(superiorfloat(b,a));
   r = cast(b,class(q));%class 返回 obj 的类的名称。
   %cast 将变量转换为不同的数据类型
else
   [q,zf] = filter(b, a, [1 zeros(1,nb-na)]);%1维数字滤波器,如果 x 为向量，则 filter 将滤波后数据以大小与 x 相同的向量形式返回。
   if mb ~= 1
      q = q(:);
   end
   if nargout > 1
      r = zeros(size(b),class(q));
      lq = length(q);
      r(lq+1:end) = a(1)*zf(1:nb-lq);
   end
end
