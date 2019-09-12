% 2.3
clear all, close all, clc;
load('hall.mat');
hall_gray_matrix = hall_gray(1:120,1:120); % ȡһС��ͼƬ��֤
a = dct2(hall_gray_matrix);
b = dct2(hall_gray_matrix);
a(:,117:120) = 0;          % �Ҳ���������
b(:,1:4) = 0;              % ����������� 
hall_gray_1 = uint8(idct2(a));
hall_gray_2 = uint8(idct2(b));
figure;
subplot(3,1,1);
imshow(hall_gray_matrix);
title('Unmodified');
subplot(3,1,2);
imshow(hall_gray_1);
title('Right');
subplot(3,1,3);
imshow(hall_gray_2);
title('Left');
