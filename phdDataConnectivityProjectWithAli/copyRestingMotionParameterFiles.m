function copyRestingMotionParameterFiles(subID)

participantNum=sprintf('%03d',subID);

fameOrder = checkFameOrder(subID); % get checked fame order from another func

if fameOrder ==0
    error('please check fame order');
end

%make participant folder
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';

if ~exist([projDir,'s',participantNum],'dir')
    mkdir([projDir,'s',participantNum]);
end
rootDir = [projDir,'s',participantNum,'\'];

if ~exist([rootDir,'prepostEncoding\preBaseline'],'dir')
    mkdir([rootDir,'prepostEncoding\preBaseline']);
end

if ~exist([rootDir,'prepostEncoding\postFam'],'dir')
    mkdir([rootDir,'prepostEncoding\postFam']);
end

if ~exist([rootDir,'prepostEncoding\postNonFam'],'dir')
    mkdir([rootDir,'prepostEncoding\postNonFam']);
end

copyfile([rootDir,'scanImgData\run_0004\rp_avol_0004.txt'],...
    [rootDir,'prepostEncoding\preBaseline\rp_avol_0004.txt']);

if mod(str2num(participantNum),2)~=0
    copyfile([rootDir,'scanImgData\run_0007\rp_avol_0004.txt'],...
        [rootDir,'prepostEncoding\postFam\rp_avol_0004.txt']);
    
    copyfile([rootDir,'scanImgData\run_0010\rp_avol_0004.txt'],...
        [rootDir,'prepostEncoding\postNonFam\rp_avol_0004.txt']);
end

if mod(str2num(participantNum),2)==0
    copyfile([rootDir,'scanImgData\run_0010\rp_avol_0004.txt'],...
        [rootDir,'prepostEncoding\postFam\rp_avol_0004.txt']);
    
    copyfile([rootDir,'scanImgData\run_0007\rp_avol_0004.txt'],...
        [rootDir,'prepostEncoding\postNonFam\rp_avol_0004.txt']);
end


