function plotCheckHeadMotionUsingRelignmentData(subID)

rootPath = ['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\s',...
                      sprintf('%03d',subID),'\scanImgData\'];

%select runs

restRuns = [4 7 10 12 13];
%restRuns = [4 7 10 12];
taskRuns = [5 6 8 9 11]; % pay specific attention to run5 6 8 9

%******************** rest runs translation**********************************
figure;

k=0;
for run = restRuns
aa = textread([rootPath,'run_',sprintf('%04d',run),'\',...
   'rp_avol_0004.txt']);
calculateSpikeMovement(run,aa,rootPath);
k = k+1;
subplot(length(restRuns),1,k)
plot(aa(:,1:3));
%title(['translation--restrun --- ', num2str(run)]);
if run == restRuns(1)
    s = ['x translation';'y translation';'z translation'];
    legend(s);
end
end
saveas(figure(1),[rootPath,'restTaskTraslation.pdf']);
close all;
%******************** rest runs rotation**********************************
figure;
k=0;
for run = restRuns
aa = textread([rootPath,'run_',sprintf('%04d',run),'\',...
   'rp_avol_0004.txt']);
    
k = k+1;
subplot(length(restRuns),1,k)
plot(aa(:,4:6)*180/pi);
title(['rotation--restrun --- ', num2str(run)]);
if run == restRuns(1)
    s = ['pitch';'roll ';'yaw  '];;
    legend(s);
end
end
saveas( figure(1),[rootPath,'restTaskRotation.pdf']);
close all;
%******************** task runs translation **********************************
figure;
k=0;
for run = taskRuns
aa = textread([rootPath,'run_',sprintf('%04d',run),'\',...
   'rp_avol_0004.txt']);
calculateSpikeMovement(run,aa,rootPath);
k = k+1;
subplot(length(taskRuns),1,k)
plot(aa(:,1:3));
title(['translation--taskrun --- ', num2str(run)]);
if run == taskRuns(1)
    s = ['x translation';'y translation';'z translation'];
    legend(s);
end
end
saveas(figure(1), [rootPath,'TaskTraslation.pdf']);
close all;
%******************** task runs rotation**********************************
figure;
k=0;
for run = taskRuns
aa = textread([rootPath,'run_',sprintf('%04d',run),'\',...
   'rp_avol_0004.txt']);
k = k+1;
subplot(length(taskRuns),1,k)
plot(aa(:,4:6)*180/pi);
title(['rotation--taskrun --- ', num2str(run)]);
if run == taskRuns(1)
    s = ['pitch';'roll ';'yaw  '];;
     legend(s);
end
end
saveas(figure(1),[rootPath,'TaskRotationtion.pdf']);
close all;
%**************************************************************************
function calculateSpikeMovement(run,aa,rootPath)
diffMove=zeros(size(aa));
diffMove(2:end,:)=diff(aa);
maxMove = max(aa)-min(aa);
maxMove(:,4:6) = maxMove(:,4:6)*180/pi;

[ir ic]=find(abs(diffMove)>1);

if max(maxMove)>3 && max(maxMove)<=5
    save([rootPath,'TooMuchMovement_run_',sprintf('%04d',run),'.txt'],'-ascii', 'maxMove');
    [ir ic]=find(abs(diffMove)>.5);
end

if max(maxMove)>5
    save([rootPath,'DeleteTooMuchMovement_run_',sprintf('%04d',run),'.txt'],'-ascii', 'maxMove');
    end
% if isempty(ir) & isempty(ic)
% cumDiffMove=tsmovavg(diffMove,'s',2,1)*2;%sum of two ajacent diff move
% if max(max(abs(cumDiffMove)))>1
%     [ir ic]=find(abs(diffMove)>.5);
% end
% end

if ~isempty(ir) & ~isempty(ic)
    spikes = unique(ir);
    spikeMove = zeros(size(diffMove,1),length(spikes));
    for nspike = 1:length(spikes)
        spikeMove(spikes(nspike),nspike) = 1;    
    end
     save([rootPath,'spikeMovement_run_',sprintf('%04d',run),'.txt'],'-ascii', 'spikeMove');
          save([rootPath,'diffMovement_run_',sprintf('%04d',run),'.txt'],'-ascii', 'diffMove');
end


% rp = spm_load(spm_select)