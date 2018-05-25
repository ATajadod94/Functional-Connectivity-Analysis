function makeMultiPmod_RememberVsForgotten(subj)

rootDir = 'D:\myStudy\picpairfMRI\';
codeDir= ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\'];

[idBlockEr idBlockDr idExcluder] = getMemoryPerformanceForEachTrial_0123_notBalanced([2 3]);
[idBlockEf idBlockDf idExcludef] = getMemoryPerformanceForEachTrial_0123_notBalanced([0 1 ]);



for subj = subj
    subj
    load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\multicond.mat']);
    
    subDir = [rootDir, 's',sprintf('%03d',subj),'\'];
    behavDataDir = [subDir,'performanceData\'];
    for irun=1:4
        ERonsets{irun}=  onsets{2*(irun-1)+1}(idBlockEr{subj,irun});
        EFonsets{irun}=  onsets{2*(irun-1)+1}(idBlockEf{subj,irun});
        
        DRonsets{irun}=  onsets{2*(irun-1)+1}(idBlockDr{subj,irun});
        DFonsets{irun}=  onsets{2*(irun-1)+1}(idBlockDf{subj,irun});
    end
    onsets{1} = cat(1,ERonsets{:});
    onsets{3} = cat(1,EFonsets{:});
    onsets{5} = cat(1,DRonsets{:});
    onsets{7} = cat(1,DFonsets{:});
    names{1} = 'Easy-Remem';
    names{3} = 'Easy-Forget';
    names{5} = 'Diff-Remem';
    names{7} = 'Diff-Forget';
    
    save([behavDataDir,'easyDifficultRememberForgottenMulticond.mat'],'names','durations','onsets');
end
%parameter modulation

%













