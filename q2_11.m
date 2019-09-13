clear all;
load('jpegcodes.mat');
load('JpegCoeff.mat');
blockCntRow = floor(height/8);
blockCntCol = floor(width/8);
blockCnt = blockCntRow*blockCntCol;
DC_decode = zeros(1, blockCnt);
last = 1;
max_sizecode_length = max(DCTAB(:,1));
code_length = length(DC_code);
m = 1;
while(last<=code_length)
    for k = 2:1:max_sizecode_length
        query = find(~any((~(DCTAB(:,2:1+k) == DC_code(last:last+k-1))), 2));
        if(length(query) == 1)
            sizee = query - 1;
            last = last+k;
            break;
        end
    end
    if(sizee ~= 0)
        last_next = last + sizee;
        if(DC_code(last))
            magnitude = bi2de(flip(DC_code(last:last_next-1)));
        else
            magnitude = -1 * bi2de(flip(~(DC_code(last:last_next-1))));
        end
        last = last_next;
    DC_decode(m) = magnitude;
    else
        DC_decode(m) = 0;
    end
    m = m +1;
end
AC_decode = cell(1,blockCnt);
last = 1;
max_sizecode_length = max(ACTAB(:,3));
code_length = length(AC_code);
m = 1;
ind = 1;
AC_decode{m} = zeros(63,1);
while(last<=code_length)
    if(AC_code(last:last+3) == logical([1,0,1,0]))
        m = m + 1;
        ind = 1;
        AC_decode{m} = zeros(63,1);
        last = last+4;
    elseif(AC_code(last:last+10) == logical([1,1,1,1,1,1,1,1,0,0,1]))
        AC_decode{m}(ind:ind+15) = zeros(16,1);
        ind = ind + 16;
        last = last+11;
    else
        for k = 2:1:max_sizecode_length
            query = find(~any((~(ACTAB(:,4:3+k) == AC_code(last:last+k-1))), 2));
            if(length(query) == 1)
                run = ACTAB(query,1);
                sizee = ACTAB(query,2);
                last = last+k;
                break;
            end
        end
         AC_decode{m}(ind:ind+run-1) = zeros(run,1);
         ind = ind + run;
         last_next = last + sizee;
         if(AC_code(last))
            magnitude = bi2de(flip(AC_code(last:last_next-1)));
         else
            magnitude = -1 * bi2de(flip(~(AC_code(last:last_next-1))));
         end
         last = last_next;
         AC_decode{m}(ind) = magnitude;
         ind = ind + 1;
    end
end

