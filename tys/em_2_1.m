% 2.1
clear all, close all, clc;
load('hall.mat');
part = hall_gray(1:10,1:10);   % ȡһС��
a = dct2(part-128);            % �ȼ������ٱ任
b = dct2(part)-dct2(ones(10,10)*128); % �ڱ任���м�����
display(a - b);                % ����������
