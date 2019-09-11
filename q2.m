clear all;
load 'hall.mat';
pic_size = size(hall_gray);
%assure that the length and height of the picture are of the multiples of 8
x_left = 8 - mod(pic_size(1),8);
y_left = 8 - mod(pic_size(2),8);
if(x_left<8)
    hall_gray((pic_size(1)+1):(pic_size(1)+x_left),:) = repmat(hall_gray(pic_size(1),:,:),x_left,1);
end
if(y_left<8)
    hall_gray(:,(pic_size(2)+1):(pic_size(2)+y_left)) = repmat(hall_gray(:,pic_size(2),:),1, y_left);
end
pic_size = size(hall_gray);
blockCntRow = floor(pic_size(1)/8);
blockCntCol = floor(pic_size(2)/8);
hall_gray_partition = mat2cell(hall_gray,8*ones(1,blockCntRow),8*ones(1,blockCntCol));

N = 8;
n = 0 : 1: N-1;
DCT = sqrt(2/N)*diag([sqrt(1/2), ones(1,N-1)])*cos(n'*(2*n + 1)*pi/(2*N));
%sample_DCT2 = dct2(sample);

%sample_DCT(1,1) = sample_DCT(1,1) - (128*8);
%sample_IDCT  = DCT'*sample_DCT*DCT;