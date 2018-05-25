function makeMultiPmodFileCombingPerformanceWithFaceRating(subID,dataName,isFamOnly)
rootDir1 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir = 'D:\myStudy\picpairfMRI\';
codeDir= [rootDir1,'matlabFunctions\'];
subDir = [rootDir, 's',sprintf('%03d',subID),'\'];
behavDataDir = [subDir,'performanceData\'];
for i = 1:length(dataName)
    load([behavDataDir,dataName{i},'multiCondPmod-',num2str(isFamOnly(i)),'.mat']); % fMRI model specification: Multiple conditions - cfg_files
%set the fist and last two trials (filers) to zero to exclude them. .
%     if strcmp(dataName{1},'performance')
% to make it consistent with the data reported in submitted manuscript,no
% change to zero is implemented
%    for j=1:length(pmod)
%        if isempty(pmod(j).param)==0
%     pmod(j).param{1}([1:2 59:60])=0;
%        end
%    end
% end
    pmodold{i} = pmod;
end
    
    %parameter modulation
pmodCmbd = struct('name',{''},'param',{},'poly',{});
for i = 1:length(dataName)
    
if isempty(find(pmodold{i}(1).param{:}==1))
    pmodold{i}(1).param{:}(randsample(60,1))=1;
end
if isempty(find(pmodold{i}(1).param{:}==-1))
    pmodold{i}(1).param{:}(randsample(60,1))=-1;
end    
pmodCmbd(1).name{i} = [dataName{i},'_Fam1'];
pmodCmbd(1).param{i} = pmodold{i}(1).param{:};
pmodCmbd(1).poly{i} = 1;


if isempty(find(pmodold{i}(3).param{:}==1))
    pmodold{i}(3).param{:}(randsample(60,1))=1;
end
if isempty(find(pmodold{i}(3).param{:}==-1))
    pmodold{i}(3).param{:}(randsample(60,1))=-1;
end
pmodCmbd(3).name{i} = [dataName{i},'_Fam2'];
pmodCmbd(3).param{i} = pmodold{i}(3).param{:};
pmodCmbd(3).poly{i} = 1;

% if isFamOnly(i)==0
%     
%     pmodCmbd(5).name{i} = [dataName{i},'_NFam1'];
%     pmodCmbd(5).param{i} = pmodold{i}(5).param{:};
%     pmodCmbd(5).poly{i} = 1;
%     
%     pmodCmbd(7).name{i} = [dataName{i},'_NFam2'];
%     pmodCmbd(7).param{i} = pmodold{i}(7).param{:};
%     pmodCmbd(7).poly{i} = 1;
% end

end
pmod = pmodCmbd;
save([behavDataDir,cat(2,dataName{:}),'multiCondPmod-',num2str(sum(isFamOnly)),'.mat'],'names','durations','onsets',...
    'pmod');