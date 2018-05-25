function convertDICOM(subID,runs)

if nargin <2
    runs = 3:13;
end

participantNumber = ['s',sprintf('%03d',subID)];
projDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
rootDir = [projDir,participantNumber,'\'];

for run = runs
dicom2nifti('dicom_dir',[rootDir,'scanRawData\SCANS\',num2str(run),'\DICOM'],...
      'subject_dir', [rootDir,'scanImgData'],'format','img','autodetect','no');
end