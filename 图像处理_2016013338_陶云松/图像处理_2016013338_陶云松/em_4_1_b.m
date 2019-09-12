% 4.1.(b)
clear all, close all, clc;

L = 3;
u = zeros(1,2^(3*L));
v = zeros(1,2^(3*L));
for i = 1:33
    color = imread([num2str(i),'.bmp']);
    [N,M,P] = size(color);
    color_modified = floor(color/2^(8-L)); % �����ƣ�8-L��λ
    cn = color_modified(:,:,1)*2^(2*L)+color_modified(:,:,2)*2^L+color_modified(:,:,3); % ƴ����ɫ
    for j = 1:N*M
        u(cn(j)+1) = u(cn(j)+1)+1;       % cn������ֱ���ۼ�����Ӧ��λ����
    end
    u = u/N/M;
    v = v+u;
end
v = v/33;
save('train.mat','v','u','L');

