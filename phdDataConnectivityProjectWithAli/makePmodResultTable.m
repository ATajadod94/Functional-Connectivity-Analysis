pmodTab = cell(5,11);

pmodTab{1,2} = 'vmPFC-L';
pmodTab{1,3} = 'vmPFC-R';
pmodTab{1,4} = 'TPL-L';
pmodTab{1,5} = 'TPL-R';
pmodTab{1,6} = 'HPC-L';
pmodTab{1,7} = 'HPC-R';
pmodTab{1,8} = 'FFA-L';
pmodTab{1,9} = 'FFA-R';
pmodTab{1,10} = 'PPA-L';
pmodTab{1,11} = 'PPA-R';


load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\',...
    'emotionPartSubj\Fam12\marsbarROIAnalysis.mat']);
for i = 1:10
    
    t(i) = marsS{1,i}.stat(1);
    p(i) = marsS{1,i}.P(1);
end
t =t([9 10 7 8 1 2 5 6 3 4]);
p =p([9 10 7 8 1 2 5 6 3 4]);

for i  = 1: 10
    if p(i)<=.05 && p(i)>.01
        pmodTab{2,i+1} = [num2str(t(i),3),'  ','*'];
    elseif p(i)<=.01
        pmodTab{2,i+1} = [num2str(t(i),3),'  ','**'];
    else
        pmodTab{2,i+1} = '-';
    end
end

pmodTab{2,1} = 'Emotion';

load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\',...
    'memory\Fam12\marsbarROIAnalysis.mat']);
for i = 1:10
    
    t(i) = marsS{1,i}.stat(1);
    p(i) = marsS{1,i}.P(1);
end
t =t([9 10 7 8 1 2 5 6 3 4]);
p =p([9 10 7 8 1 2 5 6 3 4]);

for i  = 1: 10
    if p(i)<=.05 && p(i)>.01
        pmodTab{3,i+1} = [num2str(t(i),3),'  ','*'];
    elseif p(i)<=.01
        pmodTab{3,i+1} = [num2str(t(i),3),'  ','**'];
    else
        pmodTab{3,i+1} = '-';
    end
end

pmodTab{3,1} = 'Memory';



load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\',...
    'attractivenessPartSubj\Fam12\marsbarROIAnalysis.mat']);
for i = 1:10
    
    t(i) = marsS{1,i}.stat(1);
    p(i) = marsS{1,i}.P(1);
end
t =t([9 10 7 8 1 2 5 6 3 4]);
p =p([9 10 7 8 1 2 5 6 3 4]);

for i  = 1: 10
    if p(i)<=.05 && p(i)>.01
        pmodTab{4,i+1} = [num2str(t(i),3),'  ','*'];
    elseif p(i)<=.01
        pmodTab{4,i+1} = [num2str(t(i),3),'  ','**'];
    else
        pmodTab{4,i+1} = '-';
    end
end

pmodTab{4,1} = 'Attractiveness';


load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelPmodAnalysisBinary\',...
    'familiarity\Fam12\marsbarROIAnalysis.mat']);
for i = 1:10
    
    t(i) = marsS{1,i}.stat(1);
    p(i) = marsS{1,i}.P(1);
end
t =t([9 10 7 8 1 2 5 6 3 4]);
p =p([9 10 7 8 1 2 5 6 3 4]);

for i  = 1: 10
    if p(i)<=.05 && p(i)>.01
        pmodTab{5,i+1} = [num2str(t(i),3),'  ','*'];
    elseif p(i)<=.01
        pmodTab{5,i+1} = [num2str(t(i),3),'  ','**'];
    else
        pmodTab{5,i+1} = '-';
    end
end

pmodTab{5,1} = 'Familiarity';
xlswrite(['priorPMODTable.xls'], pmodTab);