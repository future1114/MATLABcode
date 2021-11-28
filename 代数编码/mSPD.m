function L = mSPD(f)
L = zeros(2,length(sym2poly(f)));
i = 1;
while f ~= 1
    j = 1;
    [tmp,~] = mGCD(f,diff(f));
    g = f / tmp;
    while g ~= 1
        f = f / g;
        [tmp,~] = mGCD(f,g);
        h = f / tmp;
        m = g / h;
        if m ~= 1
            L(1,i) = m;
            disp('书中没有讲解 js 是什么')
            disp('所以这里会报错')
            L(2,i) = js;
            i = i + 1;
        end
        g = h;
        j = j + 1;
    end
    if f ~= 1
        f = f^(1 / q);
        s = ps;
    end
end
end