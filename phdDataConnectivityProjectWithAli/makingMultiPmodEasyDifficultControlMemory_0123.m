function makingMultiPmodEasyDifficultControlMemory_0123
[idBlockE idBlockD idExclude] = getMemoryPerformanceForEachTrial_0123([0 1 2 3]);
idIn = 1:20;
idIn = idIn(logical(1-idExclude));
iblock=[1 3 5 7];
for i = idIn
    roiDir=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\performanceData\'];

load([roiDir,'\easyDifficultmultiCondPmod-0.mat']);
for k = 1:length(iblock)
    temp = zeros(60,1);
    temp(idBlockE{i,k},1) = 1;
    temp(idBlockD{i,k},1) = -1;
pmod(1,iblock(k)).param{1,1} = temp;
end
save([roiDir,'easyDiffiucltControlMemoryPmod_0123.mat']);
end

%check the data 

% cellfun(@length,idBlockD)-cellfun(@length,idBlockE)
% 
% iblock=[1 3 5 7];
% for i = 1:20
%     roiDir=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\performanceData\'];
% 
% load([roiDir,'easyDiffiucltControlMemoryPmod_0123.mat']);
% for k = 1:length(iblock)
% countE0123(i,k)=sum(pmod(1,iblock(k)).param{1}==1);
% countD0123(i,k)=sum(pmod(1,iblock(k)).param{1}==-1);
% 
% end
% end
% countE0123-countD0123
% 
% iblock=[1 3 5 7];
% for i = 1:20
%     roiDir=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\performanceData\'];
% 
% load([roiDir,'easyDiffiucltControlMemoryPmod.mat']);
% for k = 1:length(iblock)
% countE(i,k)=sum(pmod(1,iblock(k)).param{1}==1);
% countD(i,k)=sum(pmod(1,iblock(k)).param{1}==-1);
% 
% end
% end
% countE-countD