function postEncodingCorrelationAnalysisUsingPLS

dataDir = 'D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter001-addMotionCovDespike\conn_restingConnectivity\results\firstlevel\ANALYSIS_01\';

load([dataDir, 'resultsROI_Condition001.mat']);
preEncoRest = Z;

load([dataDir, 'resultsROI_Condition002.mat']);
postFamEncoRest = Z;

load([dataDir, 'resultsROI_Condition003.mat']);
postNonFamEncoRest = Z;

%10 rois analysis
roiIndx = [117 118 127:134]; %these index can be found in variable names 
lowTriagDataIndx = LowerTriangleIndex(length(roiIndx));
roiNames = names([117 118 127:134]); roiNames2=names2([117 118 127:134]);

%stack the low triagle matrix data into a row
for i = 1:20
temp1 = preEncoRest(roiIndx, roiIndx,i);
preEnco10Stack(i,:)= temp1(lowTriagDataIndx);   
    
temp2 = postFamEncoRest(roiIndx, roiIndx,i);
postFamEnco10Stack(i,:)= temp2(lowTriagDataIndx);

temp3 = postNonFamEncoRest(roiIndx, roiIndx,i);
postNonFamEnco10Stack(i,:)= temp3(lowTriagDataIndx);
clear temp1 temp2 temp3
end

% making input data for commend line pls

datamat_list{1} = cat(1, preEnco10Stack,postFamEnco10Stack,postNonFamEnco10Stack);
% specify other parameter for pls analysis
num_subj_lst = 20;
num_cond = 3;
option.method = 2; %non-rotated
option.num_perm = 1000;
option.num_boot = 1000;
option.clim = 95;
option.stacked_designdata = [0 1 -1; -1 0.5 0.5]'; % I only have one contrast

result = pls_analysis(datamat_list, num_subj_lst, num_cond,option);



datamat_list{1} = cat(1, postFamEnco10Stack,postNonFamEnco10Stack);
% specify other parameter for pls analysis
num_subj_lst = 20;
num_cond = 2;
option.method = 2; %non-rotated
option.num_perm = 1000;
option.num_boot = 1000;
option.clim = 95;
option.stacked_designdata = [1 -1]'; % I only have one contrast

result = pls_analysis(datamat_list, num_subj_lst, num_cond,option);

% Comparing postfam vs. postnonfam
temp1=result.boot_result.compare_u(:,1);
dataForPlot = zeros(length(roiIndx));
dataForPlot(lowTriagDataIndx)= temp1;
figure;
imagesc(dataForPlot);
figure;
dataForPlot(abs(dataForPlot)<1.96)=0;
imagesc(dataForPlot);

% Comparing postencoding vs. prencoding
temp1=result.boot_result.compare_u(:,2);
dataForPlot = zeros(length(roiIndx));
dataForPlot(lowTriagDataIndx)= temp1;
figure;
imagesc(dataForPlot);
dataForPlot(abs(dataForPlot)<1.96)=0;
figure;
imagesc(dataForPlot);

% brain correlations predict fam associative memory 
load('performanceDataConcatenated.mat');
datamat_list{1} = postFamEnco10Stack;
% specify other parameter for pls analysis
num_subj_lst = 20;
num_cond = 1;
option.method = 5; %non-rotated
option.num_perm = 1000;
option.num_boot = 1000;
option.clim = 95;
option.stacked_designdata = [1]'; % I only have one contrast
option.stacked_behavdata = pairMem.intactFam;
result_FamBehave = pls_analysis(datamat_list, num_subj_lst, num_cond,option);

temp1=result_FamBehave.boot_result.compare_u(:,1);
dataForPlot = zeros(length(roiIndx));
dataForPlot(lowTriagDataIndx)= temp1;
figure;
imagesc(dataForPlot);
dataForPlot(abs(dataForPlot)<1.96)=0;
figure;
imagesc(dataForPlot);

% brain correlations predict nonfam associative memory 
load('performanceDataConcatenated.mat');
datamat_list{1} = postNonFamEnco10Stack;
% specify other parameter for pls analysis
num_subj_lst = 20;
num_cond = 1;
option.method = 5; %non-rotated
option.num_perm = 1000;
option.num_boot = 1000;
option.clim = 95;
option.stacked_designdata = [1]'; % I only have one contrast
option.stacked_behavdata = pairMem.intactNFam;
result_NFamBehave = pls_analysis(datamat_list, num_subj_lst, num_cond,option);

temp1=result_NFamBehave.boot_result.compare_u(:,1);
dataForPlot = zeros(length(roiIndx));
dataForPlot(lowTriagDataIndx)= temp1;
figure;
imagesc(dataForPlot);
dataForPlot(abs(dataForPlot)<1.96)=0;
figure;
imagesc(dataForPlot);

% plot rhpc vs. lffa in postfam and postnanfam
roiDataDir = 'D:\myStudy\picpairfMRI\restingConnectivityConn_SessionAsConditions-filter001-addMotionCovDespike\conn_restingConnectivity\results\preprocessing\';
figure;
for i = 1:20
load([roiDataDir,'ROI_Subject',sprintf('%03d',i),'_Condition002.mat']);
dataFm(:,:,i) = [data{121},data{134}];
load([roiDataDir,'ROI_Subject',sprintf('%03d',i),'_Condition003.mat']);
dataNFm(:,:,i) =[data{121},data{134}];
plot(dataFm(:,1,i),dataFm(:,2,i),'*r');
hold on;
lsline;

plot(dataNFm(:,1,i),dataNFm(:,2,i),'*b');
lsline;
hold on;
end


aa=dataFm(:,:,1);
bb=dataNFm(:,:,1);
for i = 2:20
   aa=cat(1,aa,dataFm(:,:,i));
   bb=cat(1,bb,dataNFm(:,:,i));
end
figure;
plot(aa(:,1),aa(:,2),'*r');
lsline;
hold on;
plot(bb(:,1),bb(:,2),'*b');
lsline;

figure;
for i = 1:20
    plot(dataFm(:,:,i));
%     hold on;

end

figure;  plot(mean(dataFm,3));