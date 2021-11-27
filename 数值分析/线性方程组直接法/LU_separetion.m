function [L_matrix,U_matrix,y_matrix,x_matrix] = LU_separetion(A_matrix, B_matirx) 
% LU系数矩阵分解
% 2017-11-09  xh_scu
% inputs:
%        A_matrix:输入的系数矩阵，尺寸为[n,n]
%        B_matrix:输入的乘积矩阵，尺寸为[n,1]
% outputs:
%        L_matrix:下三角阵，尺寸为[n,n]
%        U_matrix:上三角阵，尺寸为[n,n]
%        y_matrix:中间矩阵，尺寸为[n,1]
%        x_matrix:结果矩阵，尺寸为[n,1]


%% 第一步：初始化
% 获取n值
[row_a, col_a] = size(A_matrix);
% 初始化上三角阵的第一行
for j = 1:col_a % for-1
    U_matrix(1,j) = A_matrix(1,j);
end % for-1
% 初始化下三角阵的第一列
L_matrix(1,1) = 1;
for i = 2:row_a % for-2-s
    L_matrix(i,1) = A_matrix(i,1)/A_matrix(1,1); % 对应式（1.3）
end % for-2-e

%% 第二步：前向分解计算
for i = 2:row_a  % for-3-s
    for j = i:col_a % for-4-s
        temp_sum = 0;
        for k = 1:i-1 % for-5-s
            temp_sum = temp_sum + L_matrix(i,k)*U_matrix(k,j); %对应式（1.18）-上部分的求和部分
        end % for-5-e
        U_matrix(i,j) = A_matrix(i,j) - temp_sum; % 对应式（1.18）-上部分的求差部分
        temp_sum_1 = 0;
        for p = 1:i-1 % for-6-s
            temp_sum_1 = temp_sum_1 + L_matrix(j,p)*U_matrix(p,i); % 对应式（1.18）-下部分的求和部分
        end %for-6-e
        L_matrix(j,i) = (A_matrix(j,i) - temp_sum_1)/U_matrix(i,i); % 对应式（1.18）-下部分的求差再求商部分
    end % for-4-e
end % for-3-e

%% 第三步：回代计算y
x_matrix = zeros(row_a,1);
% 后向回代
% 下三角回代----计算中间矩阵Y
y_matrix(1,1) = B_matirx(1,1);
for i = 2:row_a % for-7-s
    temp_sum_2 = 0;
    for j = 1:i-1 % for-8-s
        temp_sum_2 = temp_sum_2 + L_matrix(i,j)*y_matrix(j,1);
    end % for-8-e
    y_matrix(i,1) = B_matirx(i) - temp_sum_2;
end % for-7-e

%% 第四步：回代计算x
% 上三角回代----计算结果矩阵X
x_matrix(row_a,1) = y_matrix(row_a,1)/U_matrix(row_a,col_a);
for i=row_a-1:-1:1 % for-9-s
    temp_sum_3 = 0;
    for j = i+1:row_a % for-10-s
        temp_sum_3 = temp_sum_3 + U_matrix(i,j)*x_matrix(j,1);
    end % for-10-e
    x_matrix(i,1) = (y_matrix(i,1) - temp_sum_3)/U_matrix(i,i);
end % for-9-e
end
