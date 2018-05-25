for i=1:20
 newRootDir = 'E:\zbnRawData\';
 oldRootDir = 'D:\myStudy\picpairfMRI\';
 SOURCE = [oldRootDir,'s',sprintf('%03d',i),'\scanImgData\run_0012\'];
 DESTINATION =[newRootDir,'s',sprintf('%03d',i),'\scanImgData\run_0012\'];
 if ~exist(DESTINATION,'dir')
     mkdir(DESTINATION);
 end
 [SUCCESS,MESSAGE,MESSAGEID] = copyfile(SOURCE, DESTINATION);
       
end
clear all;

for i=1:20
 newRootDir = 'E:\zbnRawData\';
 oldRootDir = 'D:\myStudy\picpairfMRI\';
 SOURCE = [oldRootDir,'s',sprintf('%03d',i),'\scanImgData\run_0013\'];
 DESTINATION =[newRootDir,'s',sprintf('%03d',i),'\scanImgData\run_0013\'];
 if ~exist(DESTINATION,'dir')
     mkdir(DESTINATION);
 end
 [SUCCESS,MESSAGE,MESSAGEID] = copyfile(SOURCE, DESTINATION);
       
end

clear all;

for i=1:20
 newRootDir = 'E:\zbnRawData\';
 oldRootDir = 'D:\myStudy\picpairfMRI\';
 SOURCE = [oldRootDir,'s',sprintf('%03d',i),'\prepostEncoding\preBaseline\'];
 DESTINATION =[newRootDir,'s',sprintf('%03d',i),'\prepostEncoding\preBaseline\'];
 if ~exist(DESTINATION,'dir')
     mkdir(DESTINATION);
 end
 [SUCCESS,MESSAGE,MESSAGEID] = copyfile(SOURCE, DESTINATION);       
end

clear all;
for i=1:20
 newRootDir = 'E:\zbnRawData\';
 oldRootDir = 'D:\myStudy\picpairfMRI\';
 SOURCE = [oldRootDir,'s',sprintf('%03d',i),'\prepostEncoding\postFam\'];
 DESTINATION =[newRootDir,'s',sprintf('%03d',i),'\prepostEncoding\postFame\'];
 if ~exist(DESTINATION,'dir')
     mkdir(DESTINATION);
 end
 [SUCCESS,MESSAGE,MESSAGEID] = copyfile(SOURCE, DESTINATION);       
end

clear all;
for i=1:20
 newRootDir = 'E:\zbnRawData\';
 oldRootDir = 'D:\myStudy\picpairfMRI\';
 SOURCE = [oldRootDir,'s',sprintf('%03d',i),'\prepostEncoding\postNonFam\'];
 DESTINATION =[newRootDir,'s',sprintf('%03d',i),'\prepostEncoding\postNonFam\'];
 if ~exist(DESTINATION,'dir')
     mkdir(DESTINATION);
 end
 [SUCCESS,MESSAGE,MESSAGEID] = copyfile(SOURCE, DESTINATION);       
end

for i=1:20
 newRootDir = 'E:\zbnRawData\';
 oldRootDir = 'D:\myStudy\picpairfMRI\';
 SOURCE = [oldRootDir,'s',sprintf('%03d',i),'\scanImgData\run_0003\w*.*'];
 DESTINATION =[newRootDir,'s',sprintf('%03d',i),'\scanImgData\run_0003\'];
 if ~exist(DESTINATION,'dir')
     mkdir(DESTINATION);
 end
 [SUCCESS,MESSAGE,MESSAGEID] = copyfile(SOURCE, DESTINATION);
       
end