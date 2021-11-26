clear all
close all
%% 理想低通
f = imread('IMG_2252.JPG');
f = rgb2gray(f);
f = im2double(f);

% 计算填充图像大小
[M,N] = size(f);
M2 = 2*M;
N2 = 2*N;

% 傅里叶变换
F = fftshift(fft2(f,M2,N2));
figure;imshow(mat2gray(log(1+abs(F))));title('傅里叶频谱');

% 生成网格坐标
u = -N:N-1;
v = -M:M-1;
[U,V] = meshgrid(u,v);
for i=1:3
    % 设计滤波器
    D = hypot(U,V);
    D0 = input('请输入截止频率：');
    H = mat2gray( D <= D0 );% 理想低通滤波器
    
    % 频域滤波
    G = F.*H;
    figure;imshow(mat2gray(log(1+abs(G))));title('频域滤波');
    1-sum(sum(abs(G).^2))/sum(sum(abs(F).^2))
    g0 = ifft2(fftshift(G));
    g = g0(1:M,1:N);
    g = real(g);
    
    subplot(2,4,1), imshow(f);title('空域图');
    subplot(2,4,5), imshow(log(abs(f)+1),[ ]);title('频域图');
    subplot(2,4,1+i),imshow(log(abs(G)+1),[ ]);title(['滤波效果,r=',num2str(D0)]);
    subplot(2,4,5+i),imshow(abs(g),[ ]);title('低通滤波后的图形');
end

%% 理想高通
% 计算填充图像大小
[M,N] = size(f);
M2 = 2*M;
N2 = 2*N;

% 傅里叶变换
F = fftshift(fft2(f,M2,N2));
% figure;subplot(1,3,1);imshow(mat2gray(log(1+abs(F))));title('傅里叶频谱');

% 生成网格坐标
u = -N:N-1;
v = -M:M-1;
[U,V] = meshgrid(u,v);
figure,
for i=1:3
    % 设计滤波器
    D = hypot(U,V);
    D0 = input('请输入截止频率：');
    H = mat2gray( D >= D0 );%理想高通滤波器
    
    % 频域滤波
    G = F.*H;
    % subplot(1,3,3);imshow(mat2gray(log(1+abs(G))));title('频域滤波');
    1-sum(sum(abs(G).^2))/sum(sum(abs(F).^2))
    g0 = ifft2(fftshift(G));
    g = g0(1:M,1:N);
    g = real(g);
    
    subplot(2,4,1), imshow(f);title('空域图');
    subplot(2,4,5), imshow(log(abs(f)+1),[ ]);title('频域图');
    subplot(2,4,1+i),imshow(log(abs(G)+1),[ ]);title(['滤波效果,r=',num2str(D0)]);
    subplot(2,4,5+i),imshow(abs(g),[ ]);title('高通滤波后的图形');
end
