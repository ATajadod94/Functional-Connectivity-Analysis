function checkFuncVolumeNums


facefMRIDCMDirectories = importDicomDirectoryExcel;
dataDir = 'C:\Users\zliu\Documents\myStudies\fixMTL\Faces_Repetiion_fMRI\';
[a ia ib]=unique(facefMRIDCMDirectories.subjID);

for i = 1:length(a)
    
        dirData = facefMRIDCMDirectories(facefMRIDCMDirectories.subjID==a(i),:);

    nfunblc =  length(dirData.myRunID)-1;
    
    for j = 1:nfunblc
        disp([i j])
        funDir =[dataDir,'subj', sprintf('%02d',a(i)),'\run',num2str(j),'\'];
        
        
        
        funVol = dir([funDir,'*.img']);
        funHDR = dir([funDir,'*.hdr']);
       
            disp(['For run***',num2str(j)]);
            disp(['******* first file name:    ',funVol(1).name]);
            disp(['******* first file name:    ',funVol(end).name]);

                 
        
    end
    
end