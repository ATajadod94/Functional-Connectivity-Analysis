function fameEffectOnFaceEval
load('faceEvalMTotal.mat');
[a b c statsAtt] = ttest(faceEvalMTotal.familiarity(:,1),faceEvalMTotal.attractiveness(:,3));
[a b c statsEmo] = ttest(faceEvalMTotal.familiarity(:,1),faceEvalMTotal.emotion(:,3));
[a b c statsfami] = ttest(faceEvalMTotal.familiarity(:,1),faceEvalMTotal.familiarity(:,3));
