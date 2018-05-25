function [lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa]=getIndividualROIsSmallBBxMatchBigBBx(isubj)
%not finished and unused

    rootDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d', isubj),'\'];
    maskDir1       = [rootDir,'encoding\analysis\'];
    maskDir2       =[rootDir,'localization\'];

[lvmpb, MHeadb] = rest_ReadNiftiImage([maskDir1,'lvmp-indivRoi.img']);
[rvmpb, MHeadb] = rest_ReadNiftiImage([maskDir1,'rvmp-indivRoi.img']);
[ltplb, MHeadb] = rest_ReadNiftiImage([maskDir1,'ltpl-indivRoi.img']);
[rtplb, MHeadb] = rest_ReadNiftiImage([maskDir1,'rtpl-indivRoi.img']);
[lhpcb, MHeadb] = rest_ReadNiftiImage([maskDir1,'lhpc-indivRoi.img']);
[rhpcb, MHeadb] = rest_ReadNiftiImage([maskDir1,'rhpc-indivRoi.img']);
[lppab, MHeadb] = rest_ReadNiftiImage([maskDir2,'L_PPABox9110991.img']);
[rppab, MHeadb] = rest_ReadNiftiImage([maskDir2,'R_PPABox9110991.img']);
[lffab, MHeadb] = rest_ReadNiftiImage([maskDir2,'L_FFABox9110991.img']);
[rffab, MHeadb] = rest_ReadNiftiImage([maskDir2,'R_FFABox9110991.img']);
    
[lvmps, MHeads] = rest_ReadNiftiImage([maskDir1,'lvmp-indivRoi-smBBox.img']);
[rvmps, MHeads] = rest_ReadNiftiImage([maskDir1,'rvmp-indivRoi-smBBox.img']);
[ltpls, MHeads] = rest_ReadNiftiImage([maskDir1,'ltpl-indivRoi-smBBox.img']);
[rtpls, MHeads] = rest_ReadNiftiImage([maskDir1,'rtpl-indivRoi-smBBox.img']);
[lhpcs, MHeads] = rest_ReadNiftiImage([maskDir1,'lhpc-indivRoi-smBBox.img']);
[rhpcs, MHeads] = rest_ReadNiftiImage([maskDir1,'rhpc-indivRoi-smBBox.img']);
[lppas, MHeads] = rest_ReadNiftiImage([maskDir2,'L_PPA.img']);
[rppas, MHeads] = rest_ReadNiftiImage([maskDir2,'R_PPA.img']);
[lffas, MHeads] = rest_ReadNiftiImage([maskDir2,'L_FFA.img']);
[rffas, MHeads] = rest_ReadNiftiImage([maskDir2,'R_FFA.img']);
   
lvmpb = logical(lvmpb);
rvmp = logical(rvmp);
ltpl = logical(ltpl);
rtpl = logical(rtpl);
lhpc = logical(lhpc);
rhpc = logical(rhpc);
lppa = logical(lppa);
rppa = logical(rppa);
lffa = logical(lffa);
rffa = logical(rffa);

lvmps = logical(lvmps);

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


threshold =0;

[gridx,gridy,gridz]=ndgrid(1:a.dim(1),1:a.dim(2),1:a.dim(3));
xyz=[gridx(:),gridy(:),gridz(:)]';%,ones(numel(gridx),1)]';
b=reshape(spm_get_data(a,xyz),a.dim);

%find mask region matrix indces that satisfies the threshold
idxvoxels=find(b>threshold);
XYZww=b(idxvoxels)';
xyz=xyz(:,idxvoxels);

% find the coordinates of the mask region
XYZMM=a.mat(1:3,:)*[xyz;ones(1,length(idxvoxels))];

% read in the templateImage header
outV = spm_vol(templateImage);
% revert the matrix M
c_iM=inv(outV.mat);

%convert the coordinates into matrix indices
c_XYZ = c_iM(1:3,:)*[XYZMM; ones(1,size(XYZMM,2))];

%read in the template image and set all data to zoeros
c_data = spm_read_vols(outV);
c_data(:,:,:) = 0;

% add the mask by settiing 1 for all the matrix indcees 
for i = 1: size(c_XYZ,2)
c_data(c_XYZ(1,i),c_XYZ(2,i),c_XYZ(3,i)) = i;
end