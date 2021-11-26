clear all
close all
%% �����ͨ
f = imread('IMG_2252.JPG');
f = rgb2gray(f);
f = im2double(f);

% �������ͼ���С
[M,N] = size(f);
M2 = 2*M;
N2 = 2*N;

% ����Ҷ�任
F = fftshift(fft2(f,M2,N2));
figure;imshow(mat2gray(log(1+abs(F))));title('����ҶƵ��');

% ������������
u = -N:N-1;
v = -M:M-1;
[U,V] = meshgrid(u,v);
for i=1:3
    % ����˲���
    D = hypot(U,V);
    D0 = input('�������ֹƵ�ʣ�');
    H = mat2gray( D <= D0 );% �����ͨ�˲���
    
    % Ƶ���˲�
    G = F.*H;
    figure;imshow(mat2gray(log(1+abs(G))));title('Ƶ���˲�');
    1-sum(sum(abs(G).^2))/sum(sum(abs(F).^2))
    g0 = ifft2(fftshift(G));
    g = g0(1:M,1:N);
    g = real(g);
    
    subplot(2,4,1), imshow(f);title('����ͼ');
    subplot(2,4,5), imshow(log(abs(f)+1),[ ]);title('Ƶ��ͼ');
    subplot(2,4,1+i),imshow(log(abs(G)+1),[ ]);title(['�˲�Ч��,r=',num2str(D0)]);
    subplot(2,4,5+i),imshow(abs(g),[ ]);title('��ͨ�˲����ͼ��');
end

%% �����ͨ
% �������ͼ���С
[M,N] = size(f);
M2 = 2*M;
N2 = 2*N;

% ����Ҷ�任
F = fftshift(fft2(f,M2,N2));
% figure;subplot(1,3,1);imshow(mat2gray(log(1+abs(F))));title('����ҶƵ��');

% ������������
u = -N:N-1;
v = -M:M-1;
[U,V] = meshgrid(u,v);
figure,
for i=1:3
    % ����˲���
    D = hypot(U,V);
    D0 = input('�������ֹƵ�ʣ�');
    H = mat2gray( D >= D0 );%�����ͨ�˲���
    
    % Ƶ���˲�
    G = F.*H;
    % subplot(1,3,3);imshow(mat2gray(log(1+abs(G))));title('Ƶ���˲�');
    1-sum(sum(abs(G).^2))/sum(sum(abs(F).^2))
    g0 = ifft2(fftshift(G));
    g = g0(1:M,1:N);
    g = real(g);
    
    subplot(2,4,1), imshow(f);title('����ͼ');
    subplot(2,4,5), imshow(log(abs(f)+1),[ ]);title('Ƶ��ͼ');
    subplot(2,4,1+i),imshow(log(abs(G)+1),[ ]);title(['�˲�Ч��,r=',num2str(D0)]);
    subplot(2,4,5+i),imshow(abs(g),[ ]);title('��ͨ�˲����ͼ��');
end
