function trPics = getPicPairTrsForEncodingBrainCorrelations
% this is to find the trs that corresponds to face-house picture paire.
% then output can be used to delete the scrambled picture trs and only
% leave face-house trs. then the brain correlations can be calculated
% without the effects of scrambled pictures.

% zhongxu liu Feb 26 2012

codeDir = pwd;
load([codeDir,'\myDesigntestPicpairFinal.mat']);
% figure;
% plot(myDesignEncode1.event(:,2));
idPics = find(myDesignEncode1.event(:,2)==3);
idPicsDu=idPics+1;
idIncl = union(idPics,idPicsDu);
timeSeq = cumsum(myDesignEncode1.event(:,1));
timeSeqShift=zeros(1,192);
timeSeqShift(2:end)=timeSeq(1:end-1);
timeSeq1 = timeSeqShift(1:2:end);
trOnset = floor(timeSeqShift(idPics)/2);
durations = 5+myDesignEncode1.event(idPicsDu,1);
trDuration = ceil(durations/2);
trN = zeros(10,60);
for i = 1:length(trOnset)  
   j = trDuration(i);
   trN(1:j,i)= [trOnset(i)+ (0:j-1)]';
end
a = unique(trN);
trPics = a(2:end);
% figure;
% plot(trPics,1,'*');

