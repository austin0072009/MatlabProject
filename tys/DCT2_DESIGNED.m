% 2.2
function a = DCT2_DESIGNED(p)
[N,~] = size(p);
D = zeros(N);              % ΪDCT����Ԥ���ռ�
D(1,:) = ones(1,N) / (N^0.5);      % ����DCT���ӵ�һ��
% ����kron���������Ʋ��������DCT����ʣ����
D(2:N,:) = (2/N)^0.5 * cos(pi/2/N * kron([1:N-1]',[1:2:2*N-1]));
a = D*double(p)*D';
end


