function out = IZigzagScanandIDCT8(in)
N = 8;
out = zeros(N,N);
zigzag8_ind = [1,9,2,3,10,17,25,18,...
    11,4,5,12,19,26,33,41,...
    34,27,20,13,6,7,14,21,...
    28,35,42,49,57,50,43,36,...
    29,22,15,8,16,23,30,37,...
    44,51,58,59,52,45,38,31,...
    24,32,39,46,53,60,61,54,...
    47,40,48,55,62,63,56,64]'; %generate by zigzag.m
                              %value fixed for enhanced efficiency
out(zigzag8_ind) = in;
QTAB = [16,11,10,16,24,40,51,61;...
    12,12,14,19,26,58,60,55;...
    14,13,16,24,40,57,69,56;...
    14,17,22,29,51,87,80,62;...
    18,22,37,56,68,109,103,77;...
    24,35,55,64,81,104,113,92;...
    49,64,78,87,103,121,120,101;...
    72,92,95,98,112,100,103,99]; %adapted from 'JpegCoeff.mat'

n = 0 : 1: N-1;
DCT = sqrt(2/N)*diag([sqrt(1/2), ones(1,N-1)])*cos(n'*(2*n + 1)*pi/(2*N));
out = out .* QTAB;
out = DCT'*out*DCT;
out = out + 128;
end