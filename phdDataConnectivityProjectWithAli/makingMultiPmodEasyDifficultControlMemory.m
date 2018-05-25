function makingMultiPmodEasyDifficultControlMemory
[idBlockE idBlockD idExclude] = getMemoryPerformanceForEachTrial([0 1 2]);
idIn = 1:20;
idIn = idIn(logical(1-idExclude));
iblock=[1 3 5 7];
for i = 1:idIn
    roiDir=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\performanceData\'];

load([roiDir,'\easyDifficultmultiCondPmod-0.mat']);
for k = 1:length(iblock)
    temp = zeros(60,1);
    temp(idBlockE{i,k},1) = 1;
    temp(idBlockD{i,k},1) = -1;
pmod(1,iblock(k)).param{1,1} = temp;
end
save([roiDir,'\easyDiffiucltControlMemoryPmod_012.mat']);
end