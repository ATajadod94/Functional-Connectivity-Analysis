function getTimeSeriesForEncodeBetaValue
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';

[lvmp, MHead] = rest_ReadNiftiImage([maskDir,'L_vmP_BBxChanged.img']);
[rvmp, MHead] = rest_ReadNiftiImage([maskDir,'R_vmP_BBxChanged.img']);
[ltpl, MHead] = rest_ReadNiftiImage([maskDir,'L_TPL_BBxChanged.img']);
[rtpl, MHead] = rest_ReadNiftiImage([maskDir,'R_TPL_BBxChanged.img']);
[lhpc, MHead] = rest_ReadNiftiImage([maskDir,'L_HPC_BBxChanged.img']);
[rhpc, MHead] = rest_ReadNiftiImage([maskDir,'R_HPC_BBxChanged.img']);
[lppa, MHead] = rest_ReadNiftiImage([maskDir,'L_PPA.img']);
[rppa, MHead] = rest_ReadNiftiImage([maskDir,'R_PPA.img']);
[lffa, MHead] = rest_ReadNiftiImage([maskDir,'L_FFA.img']);
[rffa, MHead] = rest_ReadNiftiImage([maskDir,'R_FFA.img']);

lvmp = logical(lvmp);
rvmp = logical(rvmp);
ltpl = logical(ltpl);
rtpl = logical(rtpl);
lhpc = logical(lhpc);
rhpc = logical(rhpc);
lppa = logical(lppa);
rppa = logical(rppa);
lffa = logical(lffa);
rffa = logical(rffa);

lvmp = find(lvmp==1);
rvmp = find(rvmp==1);
ltpl = find(ltpl==1);
rtpl = find(rtpl==1);
lhpc = find(lhpc==1);
rhpc = find(rhpc==1);
lppa = find(lppa==1);
rppa = find(rppa==1);
lffa = find(lffa==1);
rffa = find(rffa==1);

%  allVox = sum([length(lvmp),length(rvmp),length(ltpl),length(rtpl),length(lhpc),...
%                  length(rhpc),length(lppa),length(rppa),length(lffa),length(rffa)]);

outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\encodingBetaTimeSeriesData\';
allVoxels = cat(1,lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa);
for isubj = 1:20
    dataDir = ['G:\myStudy\picpairfMRI\s',sprintf('%03d',isubj),'\encoding\singleTrialBeta\'];
    
    if isubj ==1
        save([outDir,'roiInfo.mat'],'lvmp','rvmp','ltpl','rtpl','lhpc','rhpc',...
            'lppa','rppa','lffa','rffa');
    end
    trrange= [1:60];  icond = 1;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [61:96];  icond = 2;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [97:156];  icond = 3;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [157:192];  icond = 4;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [193:252];  icond = 5;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [253:288];  icond = 6;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [289:348];  icond = 7;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [349:384];  icond = 8;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
end

function gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels)
tr1=0;
for tr = trrange
    tr1=tr1+1;
    dataFileName = ['beta_',sprintf('%04d',tr),'.img'];
    [Data, Head] = rest_ReadNiftiImage([dataDir,dataFileName]);
    roiTimeSeriesData(tr1,:) = Data(allVoxels);
end
newName = ['subject-',sprintf('%03d',isubj),'-condition-',sprintf('%03d',icond),'.mat'];
save([outDir,newName],'roiTimeSeriesData');

