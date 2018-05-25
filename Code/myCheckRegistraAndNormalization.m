function myCheckRegistraAndNormalization(isubj,checkFlag)
%i subject id
%checkFlag ===1: check coregistration ==2 check nomormalization

spm('defaults', 'FMRI');
spm_jobman('initcfg');
facefMRIDCMDirectories = importDicomDirectoryExcel;
dataDir = 'C:\Users\zliu\Documents\myStudies\fixMTL\Faces_Repetiion_fMRI\';
[a ia ib]=unique(facefMRIDCMDirectories.subjID);

disp(isubj)
dirData = facefMRIDCMDirectories(facefMRIDCMDirectories.subjID==a(isubj),:);
nrun = size(dirData)-1;

subAnatDir = [dataDir,'subj', sprintf('%02d',a(isubj)),'\anat'];
anatImg =  GetImageList3D(subAnatDir, WildcardFilename('ws*.img'));
if checkFlag==1
    for jblc = 1:nrun
        subFuncDir =[dataDir,'subj', sprintf('%02d',a(isubj)),'\run',num2str(jblc)];
        imgFile=GetImageList4D(subFuncDir, WildcardFilename('w*.img'));
        imids = randsample(195,2)
        imgToCheck{jblc}=imgFile(imids);
    end
else
    imgToCheck{1} = 'C:\Users\zliu\Documents\myStudies\fixMTL\Faces_Repetiion_fMRI\myMatlabCode\ch2.img';
end
imgToCheck= cat(1,anatImg,imgToCheck{:})

mychecking(imgToCheck);
clearvars imgFile imids imgToCheck;

function mychecking(imgToCheck)
images = spm_vol(imgToCheck);
spm_figure('GetWin','Graphics');
spm_figure('Clear','Graphics');
spm_orthviews('Reset');

mn = length(images);
n  = round(mn^0.4);
m  = ceil(mn/n);
w  = 1/n;
h  = 1/m;
ds = (w+h)*0.02;
for ij=1:mn
    i = 1-h*(floor((ij-1)/n)+1);
    j = w*rem(ij-1,n);
    handle = spm_orthviews('Image', images{ij},...
        [j+ds/2 i+ds/2 w-ds h-ds]);
    if ij==1, spm_orthviews('Space'); end
    spm_orthviews('AddContext',handle);
    
end


