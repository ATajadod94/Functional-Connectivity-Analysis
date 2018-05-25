function mulitcondSingleTrialBeta = makingMultiCondFileForSingleTrialBeta
path = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([path 'multicond.mat']);
%durations event design duration ==0
[d{1:(60+36)*4}]=deal(0);
% names for conditions 1:60 fm1-60 61:96 fm1scrmb1:36 .. etc
for j = 1:4
    for i = 1+(96*(j-1)):96*j
        if j ==1
            if (i -(96*(j-1)))<=60
                n{i}= ['fm1-',sprintf('%02d',i-(96*(j-1)))];
            elseif (i -(96*(j-1)))>60
                n{i}= ['fmScrmb1-',sprintf('%02d',i-(96*(j-1))-60)];
            end
        elseif j==2
            if (i -(96*(j-1)))<=60
                n{i}= ['fm2-',sprintf('%02d',i-(96*(j-1)))];
            elseif (i -(96*(j-1)))>60
                n{i}= ['fmScrmb2-',sprintf('%02d',i-(96*(j-1))-60)];
            end
            
        elseif j==3
            if (i -(96*(j-1)))<=60
                n{i}= ['nfm1-',sprintf('%02d',i-(96*(j-1)))];
            elseif (i -(96*(j-1)))>60
                n{i}= ['nfmScrmb1-',sprintf('%02d',i-(96*(j-1))-60)];
            end
        elseif j==4
            if (i -(96*(j-1)))<=60
                n{i}= ['nfm2-',sprintf('%02d',i-(96*(j-1)))];
            elseif (i -(96*(j-1)))>60
                n{i}= ['nfmScrmb2-',sprintf('%02d',i-(96*(j-1))-60)];
            end
        end
    end
end
% onsets

for j = 1:4
    for i = 1+(96*(j-1)):96*j
        
        if (i -(96*(j-1)))<=60
            o{i}= onsets{j*2-1}(i-(96*(j-1)));
        elseif (i -(96*(j-1)))>60
            o{i}= onsets{j*2}(i-(96*(j-1))-60);
        end
    end
end
durations = d;
names = n;
onsets = o;
save([path,'mulitcondSingleTrialBeta.mat'],'durations','onsets','names');