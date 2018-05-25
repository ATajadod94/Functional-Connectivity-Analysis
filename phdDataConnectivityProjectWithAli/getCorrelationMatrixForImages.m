function corrMatrix = getCorrelationMatrixForImages(inputDir,outputDir,outputName)
% calculate correlations between two color images
% inputDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\IMAGE\SH\';
% using this method, i checked the images, no duplicated ones. good.
% zhongxu June 2nd, 2013

f=dir([inputDir,'*.*']);
[PATH,NAME,EXT] = fileparts([inputDir,f(end).name]);
f=[];
f = dir([inputDir,'*',EXT]);
for i = 1:length(f)
    a = imread([inputDir f(i).name]);
    imSize(i,:)= size(a);    
end
mimSize = min(imSize);

for i = 1:length(f)
    a = imread([inputDir f(i).name]);
    a = a(1:mimSize(1),1:mimSize(2),:);
    imAll(:,:,:,i)=a;
end

for i = 1:length(f)
    for j = 1:length(f)
    corrMatrix(i,j,1) = corr2(imAll(:,:,1,i),imAll(:,:,1,j));
    corrMatrix(i,j,2) = corr2(imAll(:,:,2,i),imAll(:,:,2,j));
    corrMatrix(i,j,3) = corr2(imAll(:,:,3,i),imAll(:,:,3,j));
    end
end
corrMatrix = mean(corrMatrix,3);
save([outputDir,'corrMatrixForImages',outputName,'.mat'],'corrMatrix');
