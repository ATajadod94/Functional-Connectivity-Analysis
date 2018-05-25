function deltaT = calculateTimeDelayBetweenEncodingAndRetrieval
%one caveat is whether the computer lock was accurate for the different
%testing rooms.But the error should be small. 
%calculation: the end time of the retrieval practice (emprime task # 12) - end time of encoding
%(eprime task #7)
for n = 1:20
p = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',sprintf('%03d',n),...
    '\performanceData\s',sprintf('%03d',n),'\'];
ff=dir([p,'*.txt']);
for i = 1:length(ff)
if strcmp(ff(i).name,'PicPairfMRI_01-1-7.txt')
    t1=i
end
if strcmp(ff(i).name,'PicPairfMRI_01-1-12.txt')
    t2=i
end
end
t1H = str2num(ff(t1).date(end-7:end-6));
t1M = str2num(ff(t1).date(end-4:end-3));
t2H = str2num(ff(t2).date(end-7:end-6));
t2M = str2num(ff(t2).date(end-4:end-3));
deltaT(n) = t2H*60+t2M -(t1H*60+t1M);
end
mean(deltaT)
std(deltaT)
plot(deltaT)