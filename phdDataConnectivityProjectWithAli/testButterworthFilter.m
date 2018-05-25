% testing butterworth filter with eeglab filter
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s019\prepostEncoding\restTimeS.mat']);
data0 = baseline.L_FFA';
data00 = baseline.L_TPL';

hpf=.009;
lpf=.08;

data0=data0-mean(data0);
data1=eegfilt(data0,.5,hpf,lpf,180,20);

data00=data00-mean(data00);
data01=eegfilt(data00,.5,hpf,lpf,180,20);

[a b]= butter(2 ,[hpf/.5 lpf/.5]);
data2 = filter(a,b, data0);
data02=filter(a,b,data00);
figure;
plot(data0,'k');
hold on 
plot(data00,'c');

figure
plot(data1,'g','LineWidth',2);
hold on;
plot(data01,'r','LineWidth',2);

figure;
plot(data2,'-.g','LineWidth',2);
hold on;
plot(data02,'-.r','LineWidth',2);