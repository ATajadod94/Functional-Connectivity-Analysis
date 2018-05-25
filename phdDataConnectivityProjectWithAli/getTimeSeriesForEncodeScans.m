function getTimeSeriesForEncodeScans
maskDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\masks\';
convertROIMasks([maskDir,'L_PPA.img'],[maskDir,'L_PPA_forSimiAnalysis'],[maskDir,'L_vmP.img']);
convertROIMasks([maskDir,'R_PPA.img'],[maskDir,'R_PPA_forSimiAnalysis'],[maskDir,'L_vmP.img']);
convertROIMasks([maskDir,'L_FFA.img'],[maskDir,'L_FFA_forSimiAnalysis'],[maskDir,'L_vmP.img']);
convertROIMasks([maskDir,'R_FFA.img'],[maskDir,'R_FFA_forSimiAnalysis'],[maskDir,'L_vmP.img']);

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

%to go back to the 3d mask from this 1D voxels, just lm =
%zeros(size(mask,1),size(mask,2),size(mask,3));lm(lvmp)=1, will recreate
%the mask
%  allVox = sum([length(lvmp),length(rvmp),length(ltpl),length(rtpl),length(lhpc),...
%                  length(rhpc),length(lppa),length(rppa),length(lffa),length(rffa)]);

dataDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\encodingPreprocessed\conn_eoncoding_only4Runs\results\preprocessing\';

outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\encodingTimeSeriesData\';
allVoxels = cat(1,lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa);

for isubj = 1:20
    for icond = 1:4
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





