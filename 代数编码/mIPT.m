function mIPT(f)
tic
h1=waitbar(0,'please wait');
syms x
q = 2;
n=1;
for i=1:100
    z = 0;
    h = x + n;
    l = length(sym2poly(f)) - 1;
    [~,x] = quorem(h,f);
    for k = 1:floor(l/2)
        [~,h] = quorem(h,f);
        h = h^q;
        [~,r] = mGCD(h-x,f);
        if r ~= 1
            z = 1;
            break;
        end
    end
    if r ~= 1
        z = 1;
        break;
    end
    str=['运行中...',num2str(i/100*100),'%'];
    waitbar(i/100,h1,str)
    n=i;
end
if z == 0
    disp('True 不可约')
elseif z == 1
    disp('False 可约')
else
    disp('Error 失败')
end
toc
end