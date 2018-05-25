mkdir('C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\retrievalFiles');
toDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\retrievalFiles\';
fromDir = 'D:\myStudy\picpairfMRI\';

for i = 1:20
    fname = ['PicPairfMRI_',sprintf('%02d',i),'-1-13.edat2'];
copyfile([fromDir,'s',sprintf('%03d',i),'\performanceData\s',sprintf('%03d',i),'\',fname],...
    [toDir,fname]);
end