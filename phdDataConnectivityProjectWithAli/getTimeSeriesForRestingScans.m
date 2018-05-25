function getTimeSeriesForRestingScans

maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
maskDir1 = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\';
% convertROIMasks([maskDir,'L_PPA.img'],[maskDir,'L_PPA_forSimiAnalysis'],[maskDir,'L_vmP.img']);
% convertROIMasks([maskDir,'R_PPA.img'],[maskDir,'R_PPA_forSimiAnalysis'],[maskDir,'L_vmP.img']);
% convertROIMasks([maskDir,'L_FFA.img'],[maskDir,'L_FFA_forSimiAnalysis'],[maskDir,'L_vmP.img']);
% convertROIMasks([maskDir,'R_FFA.img'],[maskDir,'R_FFA_forSimiAnalysis'],[maskDir,'L_vmP.img']);

[lvmp, MHead] = rest_ReadNiftiImage([maskDir,'L_vmP.img']);
[rvmp, MHead] = rest_ReadNiftiImage([maskDir,'R_vmP.img']);
[ltpl, MHead] = rest_ReadNiftiImage([maskDir,'L_TPL.img']);
[rtpl, MHead] = rest_ReadNiftiImage([maskDir,'R_TPL.img']);
[lhpc, MHead] = rest_ReadNiftiImage([maskDir,'L_HPC.img']);
[rhpc, MHead] = rest_ReadNiftiImage([maskDir,'R_HPC.img']);
[lppa, MHead] = rest_ReadNiftiImage([maskDir,'L_PPA_forSimiAnalysis']);
[rppa, MHead] = rest_ReadNiftiImage([maskDir,'R_PPA_forSimiAnalysis']);
[lffa, MHead] = rest_ReadNiftiImage([maskDir,'L_FFA_forSimiAnalysis']);
[rffa, MHead] = rest_ReadNiftiImage([maskDir,'R_FFA_forSimiAnalysis']);

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

% allVox = sum([length(lvmp),length(rvmp),length(ltpl),length(rtpl),length(lhpc),...
%                 length(rhpc),length(lppa),length(rppa),length(lffa),length(rffa)]);

dataDir = 'D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter00801-addMotionCovDespike\conn_restingConnectivity\results\preprocessing\';
outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\restingTimeSeriesData\';

for isubj = 1:20
    for icond = 1:5
        dataFileName = ['niftiDATA_Subject',sprintf('%03d',isubj),'_Condition',sprintf('%03d',icond),'.nii'];
        [Data, Head] = rest_ReadNiftiImage([dataDir,dataFileName]);
               
        for tr = 1:size(Data,4)
            a = Data(:,:,:,tr);
            roiTimeSeriesData(tr,:) = a(cat(1,lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa));
        end
        
        newName = ['subject-',sprintf('%03d',isubj),'-condition-',sprintf('%03d',icond),'.mat'];
        save([outDir,newName],'roiTimeSeriesData');
        
        if isubj ==1 && icond==1            
            save([outDir,'roiInfo.mat'],'lvmp','rvmp','ltpl','rtpl','lhpc','rhpc',...
                'lppa','rppa','lffa','rffa');
        end
    end
end





% roiCorrData = corrcoef(roiTimeSeriesData);
% roiCorrData = sparse(tril(roiCorrData,-1));
% 
% 
% points = randn(5,5)
% pp = tril(points-1)
% II=find(pp~=0)
% pp(II)
% 
% 
% MData(234829)
% data1=zeros(size(MData));
% data1(maskvoxels)=1;
% max(max(max(MData)))
