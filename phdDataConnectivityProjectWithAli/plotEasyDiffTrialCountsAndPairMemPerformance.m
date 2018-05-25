function plotEasyDiffTrialCountsAndPairMemPerformance

outDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\easyDiffFigures\';

[easy diffic includedSubj, trialCount]     = calculatePriorExperienceEffectOnMemory('easyDifficult', 'pairMemNoRecom');
[easyFA difficFA includedSubj, trialCount] = calculatePriorExperienceEffectOnMemory('easyDifficult', 'pairMemFalseAlarmRecom');
% for recombined false alarm, it is difficult to find corresponding
% encoding pairs because it is more likely the face and house of the
% recombined pair coming from different encoding pairs. these different
% encoding paris may not have the same easy/diffiuclt ratings. therefore, I
% only decide the easy/difficult rating of these encoding trials based on
% one picture. the original plot in inkscape is made using face image pair
% rating. the image plot on oct 26 is use house image pair rating. results
% converged that no matter which is used, fasle alarm corrected associative
% meory accuracy is higher for the easy trials than diffiuclt trails.
% this results are replecated using behavioral experiment (first one,
% already submitted), but only use hit rate without false alram
% correct.using difficultEasyTrialAssociativeIdentification.m script.
% the reason of not using false alarm is that more than 10 participants did
% not have good false alarm data (not enough trials count). Although in
% magnitude, corrected by false alarm still giving hypothesized direct, but
% no significant. however, the hit rate is signficant .0009. therefore, the
% results should be robust.


% cpin poster used pairMem including both intact and recombined pairs
% [easy diffic includedSubj, trialCount] = calculatePriorExperienceEffectOnMemory('easyDifficult', 'pairMem');
% other measures in case reviewers need to know
% [easy diffic includedSubj, trialCount] = calculatePriorExperienceEffectOnMemory('easyDifficult', 'faceMem');
% [easy diffic includedSubj, trialCount] = calculatePriorExperienceEffectOnMemory('easyDifficult', 'houseMem');
% [easy diffic includedSubj, trialCount] = calculatePriorExperienceEffectOnMemory('easyDifficult', 'faceMemSingle');
% [easy diffic includedSubj, trialCount] = calculatePriorExperienceEffectOnMemory('easyDifficult', 'houseMemSingle');
%
%trial count separated for fam nonfam;added Feb 1, 2016
FH_EasyFam = sum(trialCount(includedSubj,1:2),2);
FH_DiffiFam = sum(trialCount(includedSubj,5:6),2);

FH_EasyNFam = sum(trialCount(includedSubj,3:4),2);
FH_DiffiNFam = sum(trialCount(includedSubj,7:8),2);
[a b c d]=ttest(FH_EasyFam,FH_EasyNFam)


FH_Easy = sum(trialCount(includedSubj,1:4),2);
FH_Diffi = sum(trialCount(includedSubj,5:8),2);
SC_Easy = sum(trialCount(includedSubj,9:12),2);
SC_Diffi = sum(trialCount(includedSubj,13:16),2);
[a b c d]=ttest(FH_Easy,FH_Diffi);
[a b c d]=ttest(SC_Easy,SC_Diffi);
s=figure; h1=errorbar(mean([FH_Easy/240,FH_Diffi/240,SC_Easy/144,SC_Diffi/144],1),...
    std([FH_Easy/240,FH_Diffi/240,SC_Easy/144,SC_Diffi/144],1),'color','k','linestyle','none');
hold on;
h2=bar(mean([FH_Easy/240,FH_Diffi/240,SC_Easy/144,SC_Diffi/144],1));
set(h2,'facecolor','k');
ylabel('Trial Percentage');
ylim([0 1]);
set(gcf,'Color','w');
axis xy
box off
set(gca,'Xtick',1:4,'XTickLabel',{'FH-EASY', 'FH-DIFF', 'SC-EASY', 'SC-DIFF'});
setfigsize(s,8,'Arial',8,'Arial',5,4);
plot2svg([outDir,'easyDiffTrialCount.svg'],s);

%plot associative memory performance bars : only use intact pairs
plotEasyDiffBar(easy, diffic,'easyDiffPairMemHit_oct26',outDir)
plotEasyDiffBar(easyFA, difficFA,'easyDiffPairMemFA_oct26',outDir)

easy = easy -easyFA;
diffic = diffic -difficFA;
plotEasyDiffBar(easy, diffic,'easyDiffPairMemACCU_oct26',outDir)

%both famous and nonfamous showed the easy/difficult effects, for both
%accuracy and hit rate measures. 
addpath C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\data48\matlab_files
enf=[mean(easy(:,3:4),2),mean(diffic(:,3:4),2)];%nonfamous
ef=[mean(easy(:,1:2),2),mean(diffic(:,1:2),2)];%famous
stats = anova2x2(ef,enf,{'easy','difficult'},{'famous','nonfamous'},outpath,8,8,'facetHit')

function plotEasyDiffBar(easy, diffic,figureName,outDir)
FH_Easy = mean(easy(:,1:4),2);
FH_Diffi = mean(diffic(:,1:4),2);
s = figure; 
% errorbar(mean([FH_Easy,FH_Diffi]),...
%     std([FH_Easy,FH_Diffi],1),'color','K','linestyle','none');
% hold on;
h=bar(mean([FH_Easy,FH_Diffi],1));
hold on;
notBoxPlot([FH_Easy FH_Diffi],[],0,'line');
for i = 1:length(FH_Easy)
   line([1,2],[FH_Easy(i),FH_Diffi(i)],'Color',[rand(1,3)]); 
    
end

set(h,'facecolor','k');
ylabel('Associative Memory');
ylim([0 .8]);
set(gcf,'Color','w');
axis xy
box off
set(gca,'Xtick',1:2,'XTickLabel',{'FH-EASY', 'FH-DIFF'});
setfigsize(s,8,'Arial',8,'Arial',8,6);
[a b c d]=ttest(FH_Easy,FH_Diffi)

% plot2svg([outDir,figureName,'.svg'],s);


