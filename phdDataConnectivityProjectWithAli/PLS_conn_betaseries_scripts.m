%not working, p = .3 but patterns are similar to PPI results 
roiIndx = [117 118 127:134] 
 roiIndx = [1:90] 
load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat')  
zfam1=Z(roiIndx,roiIndx,:);
  load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat')  
zfam2=Z(roiIndx,roiIndx,:);
  load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition005.mat')  
znfam1=Z(roiIndx,roiIndx,:);
  load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition007.mat')  
znfam2=Z(roiIndx,roiIndx,:);


lowTriagDataIndx = LowerTriangleIndex(length(roiIndx));
roiNames = names([roiIndx]); roiNames2=names2([roiIndx]);

%stack the low triagle matrix data into a row
for i = 1:20
temp1 = zfam1(:,:,i);
zfam1Stack(i,:)= temp1(lowTriagDataIndx)';   
    
temp2 = zfam2(:,:,i);
zfam2Stack(i,:)= temp2(lowTriagDataIndx)';

temp3 = znfam1(:,:,i);
znfam1Stack(i,:)= temp3(lowTriagDataIndx)';


temp4 = znfam2(:,:,i);
znfam2Stack(i,:)= temp4(lowTriagDataIndx)';

clear temp1 temp2 temp3
end


%plot connectivity matrix

data{1} =mean(zfam1Stack,1);
data{2} =mean(zfam2Stack,1);
data{3} =mean(znfam1Stack,1);
titleName={'rest','thinkback','thinkahead'};
for i = 1:3
dataForPlot = zeros(length(roiIndx));
dataForPlot(lowTriagDataIndx)= data{i};
myColorScale = [-.5 .5]
s = figure;
 plotConnectivitymatrix(dataForPlot,myColorScale,titleName{i},1,1,myColorScale,-2);
 hold on;
  plotConnectivitymatrix(dataForPlot',myColorScale,titleName{i},0,0,myColorScale,-2);
  dataRoi{i}=dataForPlot+dataForPlot';
 outDir = 'C:\Users\Zhongxu\Dropbox\restingPub_ZBN (1)\data\'
 setfigsize(s,8,'Times New Roman',8,'Times New Roman',9.5 ,6.5);% fontsize (7 7 7 7) and figuresize(8.5 85)
export_fig([outDir,'roi116ConnectMatrixRaw',titleName{i}],'-r300','-tiff'); 
saveas(s, [outDir,'roi116ConnectMatrixRaw',titleName{i}], 'fig')
end
corr(data{1}',data{2}')
corr(data{1}',data{3}')
corr(data{2}',data{3}')

% a(:,1) = diag(corr(dataRoi{1}',dataRoi{2}'));
% a(:,2) =diag(corr(dataRoi{1}',dataRoi{3}'));
% a(:,3) =diag(corr(dataRoi{2}',dataRoi{3}'));
% figure;plot(a);
% figure;plot(a');
% 
% corr(a)



% % making input data for commend line pls
% 
 datamat_list{1} = cat(1, zfam1Stack,zfam2Stack,znfam1Stack,znfam2Stack);
% 
% 
% % specify other parameter for pls analysis
% 
% 
% %%%%% non-rotated PLS (predefined contrasts) %%%%%
num_subj_lst = 20;
num_cond = 4;
option.method = 2; %non-rotated
option.num_perm = 500;
option.num_boot = 500;
option.clim = 95;
 option.stacked_designdata = [1 1 -1 -1 ; 1 -1 1 -1; 1 -1 0 0 ; 0 0 -1 -1]'; % I have 3 contrasts
result = pls_analysis(datamat_list, num_subj_lst, num_cond,option);
% 
% % plot correlation matrix across all 116 ROIs for NON-ROTATED PLS
temp1=result.boot_result.compare_u(:,1); % second value represents LV of interest --> (:,1) = LV1, (:,2) = LV2, (:,3) = LV3
dataForPlot = zeros(length(roiIndx));
dataForPlot(lowTriagDataIndx)= temp1;
imagesc(dataForPlot);
dataForPlot(abs(dataForPlot)<1.28)=0; % threshold
imagesc(dataForPlot);
set(gca,'YTick',[1:length(roiIndx)],'YTickLabel',roiNames);
set(gca,'XTick',[1:length(roiIndx)],'XTickLabel',roiNames);

    
    
    
    
    
    roiIndx = [117 118 127:134] 
 roiIndx = [1:90] 
load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition001.mat')  
zfam1=Z(roiIndx,roiIndx,:);
  load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition003.mat')  
zfam2=Z(roiIndx,roiIndx,:);
  load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition005.mat')  
znfam1=Z(roiIndx,roiIndx,:);
  load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition007.mat')  
znfam2=Z(roiIndx,roiIndx,:);

load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition002.mat')  

zfam1s=Z(roiIndx,roiIndx,:);
  load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition004.mat')  
zfam2s=Z(roiIndx,roiIndx,:);
  load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition006.mat')  
znfam1s=Z(roiIndx,roiIndx,:);
  load('G:\myStudy\picpairfMRI\encodingConnectivityConn_usingBetaSeries_withWMCSFRegressor\conn_eoncodingUsingBetaSeries\results\firstlevel\ANALYSIS_01\resultsROI_Condition008.mat')  
znfam2s=Z(roiIndx,roiIndx,:);

lowTriagDataIndx = LowerTriangleIndex(length(roiIndx));
roiNames = names([roiIndx]); roiNames2=names2([roiIndx]);

%stack the low triagle matrix data into a row
for i = 1:20
temp1 = zfam1(:,:,i);
zfam1Stack(i,:)= temp1(lowTriagDataIndx)';   
    
temp2 = zfam2(:,:,i);
zfam2Stack(i,:)= temp2(lowTriagDataIndx)';

temp3 = znfam1(:,:,i);
znfam1Stack(i,:)= temp3(lowTriagDataIndx)';


temp4 = znfam2(:,:,i);
znfam2Stack(i,:)= temp4(lowTriagDataIndx)';


temp1 = zfam1s(:,:,i);
zfam1Stacks(i,:)= temp1(lowTriagDataIndx)';   
    
temp2 = zfam2s(:,:,i);
zfam2Stacks(i,:)= temp2(lowTriagDataIndx)';

temp3 = znfam1s(:,:,i);
znfam1Stacks(i,:)= temp3(lowTriagDataIndx)';


temp4 = znfam2s(:,:,i);
znfam2Stacks(i,:)= temp4(lowTriagDataIndx)';

clear temp1 temp2 temp3
end
    

 datamat_list{1} = cat(1, zfam1Stack,zfam1Stacks,zfam2Stack,zfam2Stacks,...
     znfam1Stack,znfam1Stacks,znfam2Stack,znfam2Stacks);
% 
% 
% % specify other parameter for pls analysis
% 
% 
% %%%%% non-rotated PLS (predefined contrasts) %%%%%
num_subj_lst = 20;
num_cond = 8;
option.method = 1; %non-rotated
option.num_perm = 500;
option.num_boot = 500;
option.clim = 95;
% option.stacked_designdata = [1 1 -1 -1 ; 1 -1 1 -1; 1 -1 0 0 ; 0 0 -1 -1]'; % I have 3 contrasts
result = pls_analysis(datamat_list, num_subj_lst, num_cond,option);
% 