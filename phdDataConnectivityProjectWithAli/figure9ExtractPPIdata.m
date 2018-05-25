function figure9ExtractPPIdata
%not used for pub first submission
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
age = subjInfo(:,2);
gender  = subjInfo(:,3);

datapath='D:\myStudy\picpairfMRI\';
maskdir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
outpath = 'ppiDataforFig9\';
seedId= {'PPI_L_HPC','PPI_R_HPC'};
targId= {'L_vmP','R_vmP'};
fameId = {'fam1+fam2','nonfam1+nonfam2'};
for i = 1: length(seedId)
    for j = 1:length(targId) 
        for k = 1:length(fameId)
        
outfolers = [ datapath,outpath,seedId{i},'-',targId{j},'-',fameId{k},'\'];
if ~exist(outfolers,'dir')
    mkdir(outfolers);
end



for m = 1:20
    datapathi = [datapath,'s',sprintf('%03d',m),'\encoding\analysis\',seedId{i},'\'];
      [SUCCESS,MESSAGE,MESSAGEID] = copyfile([datapathi,'con_PPI_',fameId{k},'_s',sprintf('%03d',m),'.img'],...
        [outfolers,'con_PPI_',fameId{k},'_s',sprintf('%03d',m),'.img']);

      [SUCCESS,MESSAGE,MESSAGEID] = copyfile([datapathi,'con_PPI_',fameId{k},'_s',sprintf('%03d',m),'.hdr'],...
        [outfolers,'con_PPI_',fameId{k},'_s',sprintf('%03d',m),'.hdr']);
       
end


for n = 1:20
    filenames(n,:)=[outfolers,'con_PPI_',fameId{k},'_s',sprintf('%03d',n),'.img'];
    
end
data = rex(filenames,[maskdir,targId{j},'.img'],'pca',1);

if k==1
memData = pairMem.intactFam;
elseif k==2
  memData = pairMem.intactNFam;
end

[a b memData]=regress(memData,[ones(size(subjInfo,1),1),fameOrder]);


[a sts]=robustfit([memData,age,fameOrder],data);
save([outfolers,'stats.mat'],'sts','i','j','k','seedId','targId','fameId','data','memData','filenames');
clear filenames
    end
    end
end

