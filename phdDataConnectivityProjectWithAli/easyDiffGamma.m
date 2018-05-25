load('easyDiffTrialTabulate.mat');
%easyDiffTrialTabulate.mat is calcualted using
%calculatePriorExperienceEffectOnMemory.m but the data is not returned as a
%output. so to repeat this, the cal...m file need to be run in debug mode
%and save the data before exit the debug mode
meanTab = [sum(easyHit,2), sum(easyTotal,2)-sum(easyHit,2),sum(difficHit,2),sum(difficTotal,2)-sum(difficHit,2)]

for i = 1:20
   itab =  [meanTab(i,[1 2]);meanTab(i,[3 4])];
    g(i) = gkgammatst(itab,.05,1);
end
g = g(includedSubj);
[a b c ]=ttest(g,0);
mean(g)