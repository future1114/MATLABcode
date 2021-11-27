# README
# 线性方程组直接法
## test.m
主函数调用下面的函数

CPEE.m和GuassE.m和L_U.m和LU_separetion.m

## LU_separetion.m
function [L_matrix,U_matrix,y_matrix,x_matrix] = LU_separetion(A_matrix, B_matirx) 
% LU系数矩阵分解

% inputs:

%        A_matrix:输入的系数矩阵，尺寸为[n,n]

%        B_matrix:输入的乘积矩阵，尺寸为[n,1]

% outputs:

%        L_matrix:下三角阵，尺寸为[n,n]

%        U_matrix:上三角阵，尺寸为[n,n]

%        y_matrix:中间矩阵，尺寸为[n,1]

%        x_matrix:结果矩阵，尺寸为[n,1]

LU分解
## GuassE.m
function [X, t]=GuassE(A,b)

% Gaussian Elimination
## CPEE.m
function [X, t]=CPEE(A,b)

% Column Principal Element Elimination

%列主元消去法
