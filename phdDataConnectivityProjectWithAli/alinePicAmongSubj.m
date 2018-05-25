function alinePicAmongSubj

figSize=[300 380];
figType='SH';
allCorresp.SH=doForEachFigType(figType,figSize);

figSize=[300 225];
figType='FF';
allCorresp.FF=doForEachFigType(figType,figSize);

figSize=[300 225];
figType='FM';
allCorresp.FM=doForEachFigType(figType,figSize);

figSize=[300 225];
figType='NFF';
allCorresp.NFF=doForEachFigType(figType,figSize);

figSize=[300 225];
figType='NFM';
allCorresp.NFM=doForEachFigType(figType,figSize);
subID=[3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19];

save('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\picCorrespondenceAcrossSubj.mat',...
    'allCorresp','subID');

function allCoresp=doForEachFigType(figType,figSize)

datadir = 'C:\Users\Zhongxu\Documents\dropboxbackup\picpair\zhongxufMRI_toRotman\';
subID=[3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19];
for i = 1:length(subID)
subdir = [datadir,'image',sprintf('%03d',subID(i)),'\IMAGE\',figType,'\'];
fh = dir([subdir,'*.jpeg']);
for jh=1:length(fh)
  a = imread([subdir,fh(jh).name]);
  a=a(1:figSize(1),1:figSize(2),:);
% housepic(:,jh,i) = reshape(a(:,:,1),size(a,1)*size(a,2),1);
facepic(:,jh,i) = reshape(a(:,:,1),size(a,1)*size(a,2),1);

end
end

% corbtw=corr(double([housepic(:,:,1),housepic(:,:,2)]));
facepic=double(facepic);

for sub1 = 1%: size(facepic,3)-1
    for sub2 = sub1+1 : size(facepic,3)
corbtw=corr(double([facepic(:,:,sub1),facepic(:,:,sub2)]));
corbtw(corbtw<.98)=0;
corbtw(corbtw>.98)=1;
if sum(sum(corbtw)) ~= 4*size(facepic,2)
    disp(['check data-',num2str(sub1),'-',num2str(sub2)])
end
for ncol1=1:size(facepic,2)
    for ncol2=1:size(facepic,2)
        corval = corr(facepic(:,ncol1,sub1),facepic(:,ncol2,sub2));
        if corval > .98
            idcol(ncol1,1)=ncol2;
        end
    end
end
allCoresp(:,sub2)=idcol;
    end
end  
allCoresp(:,1) = 1:size(facepic,2);
    

% figure;imagesc(corbtw)