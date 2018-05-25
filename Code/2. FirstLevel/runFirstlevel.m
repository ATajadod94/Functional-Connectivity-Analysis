%first level analysis

%%face-house encoding runs
% MNI space data (do not keep residual images)
for subj = 1:20
   analysislog{subj} = doFirstLevelFaceHouseTaskAnalysis_MNI(subj);    
end
save('faceHouseAnalysisLog_MNI.mat','analysislog');





%% localizer analyhsis

%MNI data (do not keep residual images)

for subj = 1:20
   analysislog_LocalizerMNI{subj} = doFirstLevellocalizer_MNI(subj);    
end
save('analysislog_LocalizerMNI.mat','analysislog_LocalizerMNI');



%Native space data (keep residual images. modify spm_spm.m 'delete residual
%iamges'
for subj = 1:20
   analysislog_FaceHouseNative{subj} = doFirstLevelFaceHouseTaskAnalysis_Native(subj);    
end
save('analysislog_FaceHouseNative.mat','analysislog_FaceHouseNative');
%Native space data (keep residual images)


for subj = 1:20
   analysislog_LocalizerNative{subj} = doFirstLevellocalizer_NATIVE(subj);    
end
save('analysislog_LocalizerNative.mat','analysislog_LocalizerNative');
