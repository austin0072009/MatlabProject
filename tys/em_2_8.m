% 2.8
%clear all, close all, clc;
load('hall.mat');
load('JpegCoeff.mat');
[N,M] = size(hall_gray);
n = 1;
a = zeros(64,N*M/64);         % Ԥ������������ϵ������Ŀռ�
for i = 1:8:N-7
    for j = 1:8:M-7
        part = hall_gray(i:i+7,j:j+7);      % �ֿ�
        c = dct2(part-128);                 % DCT���Ҽ�ס���ؼ�ȥ128
        c0 = round(c./QTAB);                % ����
        a(:,n) = ZIGZAG(c0);                % Zig-Zagɨ��
        n = n+1;
    end
end

        
        