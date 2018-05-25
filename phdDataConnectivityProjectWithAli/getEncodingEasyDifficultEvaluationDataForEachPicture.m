function [faceCorr, houseCorr,surrogateCorr] = getEncodingEasyDifficultEvaluationDataForEachPicture
%get face evaluation data corresponding to encoding trials that have the
%face pictures. this can be used to change design matrix in fmri analysis
%or treated as modualation factors (in parameter modualation in fmri
%design.)
% the fillings (4 pictures for each condition) were not evaluated
%******need change participant number for each participant (a string)******
% load design data in which stimEncode1 stim list is used
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\';
load([rootDir,'myDesigntestPicpairFinal.mat']);

load([rootDir,'picCorrespondenceAcrossSubj.mat']);

%fam1
npic=28;
[picsEvalAll, FFpicIds] =getAllPicEval(subID,stimEncode1.fmpair, 'FF',npic);
[picsEvalAll1, FMpicIds] =getAllPicEval(subID,stimEncode1.fmpair, 'FM',npic);
[FFin,FFcorresp] = calculateEval(npic, allCorresp.FF);%for face, 56 for house
[FMin, FMcorresp] = calculateEval(npic, allCorresp.FM);%for face, 56 for house
fam1 = calInterSubjCorr(FFin,FMin,FFpicIds,FMpicIds,FFcorresp,FMcorresp,picsEvalAll,1);


%fam2
npic=28;
[picsEvalAll, FFpicIds] =getAllPicEval(subID,stimEncode1.fmShuffled{1,1}, 'FF',npic);
[picsEvalAll1, FMpicIds] =getAllPicEval(subID,stimEncode1.fmShuffled{1,1}, 'FM',npic);
[FFin,FFcorresp] = calculateEval(npic, allCorresp.FF);%for face, 56 for house
[FMin, FMcorresp] = calculateEval(npic, allCorresp.FM);%for face, 56 for house
fam2 = calInterSubjCorr(FFin,FMin,FFpicIds,FMpicIds,FFcorresp,FMcorresp,picsEvalAll,2);


%nonfam1
npic=28;
[picsEvalAll, FFpicIds] =getAllPicEval(subID,stimEncode1.nfmpair, 'NFF',npic);
[picsEvalAll1, FMpicIds] =getAllPicEval(subID,stimEncode1.nfmpair, 'NFM',npic);
[FFin,FFcorresp] = calculateEval(npic, allCorresp.NFF);%for face, 56 for house
[FMin, FMcorresp] = calculateEval(npic, allCorresp.NFM);%for face, 56 for house
nonfam1 = calInterSubjCorr(FFin,FMin,FFpicIds,FMpicIds,FFcorresp,FMcorresp,picsEvalAll,3);


%fam2
npic=28;
[picsEvalAll, FFpicIds] =getAllPicEval(subID,stimEncode1.nfmShuffled{1,1}, 'NFF',npic);
[picsEvalAll1, FMpicIds] =getAllPicEval(subID,stimEncode1.nfmShuffled{1,1}, 'NFM',npic);
[FFin,FFcorresp] = calculateEval(npic, allCorresp.NFF);%for face, 56 for house
[FMin, FMcorresp] = calculateEval(npic, allCorresp.NFM);%for face, 56 for house
nonfam2 = calInterSubjCorr(FFin,FMin,FFpicIds,FMpicIds,FFcorresp,FMcorresp,picsEvalAll,4);


% House fam1
npic=56;
colNum=2;
[picsEvalAll, FFpicIds] =getAllPicEval(subID,stimEncode1.fmpair, 'SH',npic,colNum);
[FFin,FFcorresp] = calculateEval(npic, allCorresp.SH);%for face, 56 for house
fam1H = calInterSubjCorrSH(FFin,FFpicIds,FFcorresp,picsEvalAll,1);

% House fam2
npic=56;
colNum=2;
[picsEvalAll, FFpicIds] =getAllPicEval(subID,stimEncode1.fmShuffled{1,1}, 'SH',npic,colNum);
[FFin,FFcorresp] = calculateEval(npic, allCorresp.SH);%for face, 56 for house
fam2H = calInterSubjCorrSH(FFin,FFpicIds,FFcorresp,picsEvalAll,2);



% House nfam1
npic=56;
colNum=2;
[picsEvalAll, FFpicIds] =getAllPicEval(subID,stimEncode1.nfmpair, 'SH',npic,colNum);
[FFin,FFcorresp] = calculateEval(npic, allCorresp.SH,1);%for face, 56 for house
nonfam1H = calInterSubjCorrSH(FFin,FFpicIds,FFcorresp,picsEvalAll,3);



% House nfam2
npic=56;
colNum=2;
[picsEvalAll, FFpicIds] =getAllPicEval(subID,stimEncode1.nfmShuffled{1,1}, 'SH',npic,colNum);
[FFin,FFcorresp] = calculateEval(npic, allCorresp.SH,1);%for face, 56 for house
nonfam2H = calInterSubjCorrSH(FFin,FFpicIds,FFcorresp,picsEvalAll,4);

faceCorr =([fam1',fam2',nonfam1',nonfam2']);
houseCorr = ([fam1H',fam2H',nonfam1H',nonfam2H']);



    
    for kk = 1:10000
        rng(kk+1);
        n=randsample(15:25,1);
        easyRate = sum(sum(sum(picsEvalAll==1)))/(size(picsEvalAll,1)*size(picsEvalAll,2)*size(picsEvalAll,3));
        x1=ones(n,1);
        rng(kk+2);
        x1(randsample(n,floor(n*easyRate)),1)=-1;
        x2=ones(n,1);
        rng(kk+3);
        x2(randsample(n,floor(n*easyRate)),1)=-1;        
        surrogateCorr(kk) = corr(x1,x2);
    end
save(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\picEasyDiffInterSubjCorr.mat'],...
      'faceCorr', 'houseCorr','surrogateCorr');



% save([outpath,'easyDifficultEval.mat'],'picsEval','scrmEval');

function corrVal = calInterSubjCorrSH(FFin,FFpicIds,FFcorresp,picsEvalAll,runVal)
%female
n=0;
for subj1=1:size(FFpicIds,2)-1
    for subj2 = subj1+1:size(FFpicIds,2)
        
        
        a = FFcorresp(:,subj2,subj1);
        b=a(FFin(:,subj2,subj1));
        if min(b) > 56 % for house nonfam
            b=b-56;
        end
        idf2=FFpicIds(b,subj2);
        idf1=FFpicIds(FFin(:,subj2,subj1),subj1);
        
        if length(idf1)>=5
            n=n+1;
            corrVal(n)=corr(picsEvalAll(idf1,runVal,subj1),picsEvalAll(idf2,runVal,subj2));
            
        end
    end
end

function corrVal = calInterSubjCorr(FFin,FMin,FFpicIds,FMpicIds,FFcorresp,FMcorresp,picsEvalAll,runVal)
%female
n=0;
for subj1=1:size(FFpicIds,2)-1
    for subj2 = subj1+1:size(FFpicIds,2)
        a = FFcorresp(:,subj2,subj1);
        b=a(FFin(:,subj2,subj1));
        idf2=FFpicIds(b,subj2);
        idf1=FFpicIds(FFin(:,subj2,subj1),subj1);
        
        a = FMcorresp(:,subj2,subj1);
        b=a(FMin(:,subj2,subj1));
        idm2=FMpicIds(b,subj2);
        idm1=FMpicIds(FMin(:,subj2,subj1),subj1);
        
        %         c = FMcorresp;
        %         d= c(FMin(:,subj2),subj2);
        %         idm2=FMpicIds(d,subj2);
        %         idm1=FMpicIds(FMin(:,subj2),subj1);
        
        if length(idf1)>=5 && length(idm1)>=5
            n=n+1;
            corrVal(n)=corr(cat(1,picsEvalAll(idf1,runVal,subj1),picsEvalAll(idm1,runVal,subj1)),...
                cat(1,picsEvalAll(idf2,runVal,subj2),picsEvalAll(idm2,runVal,subj2)));
            
        end
    end
end

function [sharepicId, newcorres] = calculateEval(npic, allCorresp,nonfamSH)
if nargin ==2
    nonfamSH=0;
end

for i = 1:size(allCorresp,2)
    [temp1 ai]=sort(allCorresp(:,i),'ascend');
    bb=allCorresp(ai,:);
    if nonfamSH==1
        cc=bb(npic+1:npic*2,:);
        for j = 1:npic
            sharepicId(j,:,i) =  cc(j,:) >= npic +1 & cc(j,:)<=npic*2;
        end
    else
        cc=bb(1:npic,:);
        for j = 1:npic
            sharepicId(j,:,i) = cc(j,:)<=npic;
        end
    end
    
    
    newcorres(:,:,i)=cc;
end

function [picsEvalAll, picIds] =getAllPicEval(subID,fmpair, picType,npic,colNum)

if nargin <=4
    colNum=1;
end
for subj=1:length(subID)
    datapath = ['D:\myStudy\picpairfMRI\',...
        's', sprintf('%03d',subID(subj)),'\performanceData\'];
    outpath = datapath;
    
    load([datapath,'easyDifficultEval.mat']);
    
    picsEval(picsEval==0)=2;
    picsEval(picsEval==2)=-1;
    picsEvalAll(:,:,subj)=picsEval;
    
    idFamScrm = find(cell2mat(fmpair(:,5))==999); %scrambles id
    idFamPics = setdiff(1:96, idFamScrm)'; %pictures id
    picnames = fmpair(idFamPics,colNum);
    
    if sum(cell2mat(strfind(picnames, [picType,sprintf('%03d',57)]))) %for nonfamous condition SH from 57-112
        for mm=1:npic
            pics{mm}=[picType,sprintf('%03d',mm+56),'.jpeg'];
        end
    else
        for mm=1:npic
            pics{mm}=[picType,sprintf('%03d',mm),'.jpeg'];
        end
    end
    
    [x1,x2]=ismember(picnames,pics);
    [y1,y2]=sort(x2);
    picIds(:,subj) = y2(end-npic+1:end);
    
    if sum(y1(end-npic+1:end) - [1:npic]') ~= 0
        disp('something is wrong, check the data')
    end
end