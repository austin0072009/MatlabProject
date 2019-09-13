function AC_decode = ACDecoding(AC_code, blockCnt)
load('JpegCoeff.mat','ACTAB');
AC_decode = cell(1,blockCnt);
last = 1;
max_sizecode_length = max(ACTAB(:,3));
code_length = length(AC_code);
m = 1;
ind = 1;
AC_decode{m} = zeros(63,1);
while(last<=code_length)
    if(AC_code(last:last+3) == logical([1,0,1,0]))
        last = last+4;
        if(last <= code_length)
        	m = m + 1;
            ind = 1;
            AC_decode{m} = zeros(63,1);
        end
    elseif(AC_code(last:last+10) == logical([1,1,1,1,1,1,1,1,0,0,1]))
        AC_decode{m}(ind:ind+15) = zeros(16,1);
        ind = ind + 16;
        last = last+11;
    else
        for k = 2:1:max_sizecode_length
            query = find(~any((~(ACTAB(:,4:3+k) == AC_code(last:last+k-1))), 2));
            if(length(query) == 1)
                if(query == 4 || query == 62)
                    k = k + 1; %ZRL and EOB are not included in the ACTAB, 
                               % which destroy the prefix encoding
                               % property! It is essential to add this
                               % conditioning!  HOW CAN YOU GIVE ME AN
                               % INCOMPLETE ACTAB WITHOUT MENTIONING IN THE
                               % INSTRUCTIONS?
                end
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
end