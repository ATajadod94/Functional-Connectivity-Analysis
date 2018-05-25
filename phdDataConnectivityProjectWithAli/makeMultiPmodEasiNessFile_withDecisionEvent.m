function makeMultiPmodEasiNessFile_withDecisionEvent(subID)

rootDir = 'D:\myStudy\picpairfMRI\';
codeDir= ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\'];
subDir = [rootDir, 's',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];

%load behavorial data

    load([behavDataDir,'easyDifficultPic&ScrmmultiCondPmod-0.mat']);


for icond=9:16
    names{icond} = [names{icond-8},'_easyDiffResp'];
    if icond==1+8 | icond==3+8 |icond==5+8 |icond==7+8
    onsets{icond}=onsets{icond-8}+3.5;
    else
     onsets{icond}=onsets{icond-8}+1.5;   
    end
    durations{icond}=0;
    pmod(icond)=pmod(icond-8);
end
%parameter modulation

% 
save([behavDataDir,'easyDifficultPic&ScrmmultiCondPmod-EncodingRespond16Conds-0.mat'],'names','durations','onsets',...
     'pmod','minTrialCount');





    
    
    
    
    
    
    
