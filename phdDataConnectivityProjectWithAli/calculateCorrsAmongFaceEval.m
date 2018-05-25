function calculateCorrsAmongFaceEval
blocks = 1;

for i = 1:20
    dataDir = ['D:\myStudy\picpairfMRI\s',...
        sprintf('%03d',i),'\performanceData\'];
    load([dataDir, 'emotionEval.mat']);
    load([dataDir, 'familiarityEval.mat']);
    load([dataDir, 'attractivenessEval.mat']);
    load([dataDir, 'memoryEval.mat']);
    load([dataDir, 'easyDifficultEval.mat']);
    load  myDesigntestPicpairFinal
    idPic = find(myDesignEncode1.picDur ==3500);
    
    famil(:,i)=familiarityEval(idPic(3:end-2),blocks);
    emo(:,i)=emotionEval(idPic(3:end-2),blocks);
    mem(:,i) = memoryEval(idPic(3:end-2),blocks);
    att(:,i) = attractivenessEval(idPic(3:end-2),blocks);
    Easy(:,:,i) = picsEval(3:end-2,:);
    [Rsubj(:,:,i),Psubj(:,:,i)]=corr([att(:,i),emo(:,i),famil(:,i),mem(:,i)]);
    % t test famous vs nonfamous
    [a pAtt(i) c tAtt(i)] = ttest(emotionEval(idPic(3:end-2),1),emotionEval(idPic(3:end-2),3));
%    subplot(5,4,i)
%     [H,AX,BigAx,P,PAx]=plotmatrix([att(:,i),emo(:,i),famil(:,i),mem(:,i)]); 
%     axes(AX(1,2));
%     lsline;
%     axes(AX(1,3));
%     lsline;
%     axes(AX(1,4));
%     lsline;
%     axes(AX(2,3));
%     lsline;  
%     axes(AX(2,4));
%     lsline; 
%     axes(AX(3,4));
%     lsline;

end
datacat = [reshape(att,56*20,1), reshape(emo,56*20,1), reshape(famil,56*20,1),reshape(mem,56*20,1)];
dataM = [mean(att,2), mean(emo,2), mean(famil,2),mean(mem,2)];

easyM = squeeze(mean(Easy,3));
[r, p]= corr([dataM easyM(:,1)]);

