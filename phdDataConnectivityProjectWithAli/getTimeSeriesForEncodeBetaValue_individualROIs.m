function getTimeSeriesForEncodeBetaValue_individualROIs

outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\encodingBetaTimeSeriesData\';
for isubj = 1:20
    disp(isubj)
    [lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa]=getIndividualROIs(isubj,2);
    
    
    allVoxels = cat(1,lvmp, rvmp, ltpl, rtpl, lhpc, rhpc, lppa, rppa, lffa, rffa);
    
    dataDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',isubj),'\encoding\singleTrialBeta\'];
    
%     if isubj ==1
%         save([outDir,'roiInfo.mat'],'lvmp','rvmp','ltpl','rtpl','lhpc','rhpc',...
%             'lppa','rppa','lffa','rffa');
%     end
    trrange= [1:60];  icond = 1;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [61:96];  icond = 2;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [97:156];  icond = 3;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [157:192];  icond = 4;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [193:252];  icond = 5;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [253:288];  icond = 6;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [289:348];  icond = 7;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    trrange= [349:384];  icond = 8;
    gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels);
    
    clear allVoxels;
    save([outDir,'roiInfo-',num2str(isubj),'.mat'],'lvmp','rvmp','ltpl','rtpl','lhpc','rhpc',...
        'lppa','rppa','lffa','rffa');
    
end

function gettimeseriesforeachcondtion(isubj,icond,trrange,dataDir,outDir,allVoxels)
tr1=0;
for tr = trrange
    tr1=tr1+1;
    dataFileName = ['beta_',sprintf('%04d',tr),'.img'];
    [Data, Head] = rest_ReadNiftiImage([dataDir,dataFileName]);
    Data = changeBBox(Data,Head); %change small bbox to big bbox
    roiTimeSeriesData(tr1,:) = Data(allVoxels);
end
newName = ['subject-',sprintf('%03d',isubj),'-condition-',sprintf('%03d',icond),'.mat'];
save([outDir,newName],'roiTimeSeriesData');

function c_data = changeBBox(Data,Head)
templateMask = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\similarityAnalysis\restingProcessedData\niftiDATA_Subject020_Condition005.nii';
[lvmpb, MHeadb] = rest_ReadNiftiImage(templateMask,1);
threshold =-inf;

[gridx,gridy,gridz]=ndgrid(1:Head.dim(1),1:Head.dim(2),1:Head.dim(3));
xyz=[gridx(:),gridy(:),gridz(:)]';%,ones(numel(gridx),1)]';


%find mask region matrix indces that satisfies the threshold
idxvoxels=find(Data>threshold);
XYZww=Data(idxvoxels)';
xyz=xyz(:,idxvoxels);

% find the coordinates of the mask region
XYZMM=Head.mat(1:3,:)*[xyz;ones(1,length(idxvoxels))];

% read in the templateImage header
outV = MHeadb;
% revert the matrix M
c_iM=inv(outV.mat);

%convert the coordinates into matrix indices
c_XYZ = c_iM(1:3,:)*[XYZMM; ones(1,size(XYZMM,2))];

%read in the template image and set all data to zoeros
c_data = lvmpb;
% c_data(:,:,:) = 0;
% id1=c_data;

% add the mask by settiing 1 for all the matrix indcees 
for i = 1: size(c_XYZ,2)
c_data(c_XYZ(1,i),c_XYZ(2,i),c_XYZ(3,i)) = XYZww(i);
% id1(c_XYZ(1,i),c_XYZ(2,i),c_XYZ(3,i))=i;
end
% 
% id2=find(id1>0);
% outV.fname = [dataDir,'testingConvertBBoxTobedeleted.img'];
% outputMask = [dataDir,'testingConvertBBoxTobedeleted.img'];
% outputMask1 = [dataDir,'testingConvertBBoxTobedeleted1.img'];
% 
% % write the new mask image
% rest_WriteNiftiImage(c_data, outV,outputMask);
% rest_WriteNiftiImage(Data,Head,outputMask1);


