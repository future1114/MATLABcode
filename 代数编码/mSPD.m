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
            disp('����û�н��� js ��ʲô')
            disp('��������ᱨ��')
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