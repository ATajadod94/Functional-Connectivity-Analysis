function [lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa]=getIndividualROIs(isubj,chooseBBox)

if nargin < 2
    chooseBBox =1;
end
    rootDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d', isubj),'\'];
    maskDir1       = [rootDir,'encoding\analysis\'];
    maskDir2       =[rootDir,'localization\'];
    if chooseBBox ==1
[lvmp, MHead] = rest_ReadNiftiImage([maskDir1,'lvmp-indivRoi.img']);
[rvmp, MHead] = rest_ReadNiftiImage([maskDir1,'rvmp-indivRoi.img']);
[ltpl, MHead] = rest_ReadNiftiImage([maskDir1,'ltpl-indivRoi.img']);
[rtpl, MHead] = rest_ReadNiftiImage([maskDir1,'rtpl-indivRoi.img']);
[lhpc, MHead] = rest_ReadNiftiImage([maskDir1,'lhpc-indivRoi.img']);
[rhpc, MHead] = rest_ReadNiftiImage([maskDir1,'rhpc-indivRoi.img']);
[lppa, MHead] = rest_ReadNiftiImage([maskDir2,'L_PPABox9110991.img']);
[rppa, MHead] = rest_ReadNiftiImage([maskDir2,'R_PPABox9110991.img']);
[lffa, MHead] = rest_ReadNiftiImage([maskDir2,'L_FFABox9110991.img']);
[rffa, MHead] = rest_ReadNiftiImage([maskDir2,'R_FFABox9110991.img']);
    else
[lvmp, MHead] = rest_ReadNiftiImage([maskDir1,'lvmp-indivRoi-smBBox.img']);
[rvmp, MHead] = rest_ReadNiftiImage([maskDir1,'rvmp-indivRoi-smBBox.img']);
[ltpl, MHead] = rest_ReadNiftiImage([maskDir1,'ltpl-indivRoi-smBBox.img']);
[rtpl, MHead] = rest_ReadNiftiImage([maskDir1,'rtpl-indivRoi-smBBox.img']);
[lhpc, MHead] = rest_ReadNiftiImage([maskDir1,'lhpc-indivRoi-smBBox.img']);
[rhpc, MHead] = rest_ReadNiftiImage([maskDir1,'rhpc-indivRoi-smBBox.img']);
[lppa, MHead] = rest_ReadNiftiImage([maskDir2,'L_PPA.img']);
[rppa, MHead] = rest_ReadNiftiImage([maskDir2,'R_PPA.img']);
[lffa, MHead] = rest_ReadNiftiImage([maskDir2,'L_FFA.img']);
[rffa, MHead] = rest_ReadNiftiImage([maskDir2,'R_FFA.img']);
    end

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

