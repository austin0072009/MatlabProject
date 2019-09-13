% 3.1.��1��
function hall_color_1 = HIDE_1(M)
load('hall.mat');

hall_color_1 = mod(hall_color(:,:,1),2);       % ȡ���λ
[P,W] = size(hall_color_1);
hide = zeros(P,W);
b = dec2bin(M)-'0';        % ��������ϢMת��Ϊ�����ƾ���
[p,q] = size(b);
a = zeros(p,7);
a(:,7-q+1:7) = b;          % �е��ַ�����7λ������7λ
a = a';                    
for k = 1:7*length(M)
    hide(k) = a(k);
end
for i = 1:P                % ����������Ϣ
    for j = 1:W
        if hide(i,j) == 0
            hall_color_1(i,j) = 0;
        else
            hall_color_1(i,j) = 1;
        end
    end
end
hall_color_1 = hall_color_1+hall_color;        % ��ԭ����������Ϣ�ľ���

figure;
imshow(hall_color_1);
save('hide_1_half.mat','hall_color_1');
end
