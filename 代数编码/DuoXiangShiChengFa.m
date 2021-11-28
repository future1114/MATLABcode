function c = DuoXiangShiChengFa(a, b, shape)

if nargin < 3
    shape = 'full';
end
if isstring(shape)
    shape = char(shape);
end


c = conv2(a(:),b(:),shape);


if shape(1) == 'f' || shape(1) == 'F'  
    if length(a) > length(b)
        if size(a,1) == 1 
            c = c.';
        end
    else
        if size(b,1) == 1 
            c = c.';
        end
    end
else
    if size(a,1) == 1 
        c = c.';
    end
end
