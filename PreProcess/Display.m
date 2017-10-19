Home = '/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess';
Subjects = dir(Home);
Subjects = Subjects(3:end);
Subject = inputdlg('Please enter a Subject Number or Enter 0 for Random selection');
Subject = Subject{:};
Subject = str2double(Subject);
if Subject == 0 
    Subject = randi(20);
end

SubjectFolder = fullfile(Home,['Subject_',sprintf('%02d',Subject)]);

Runs = dir(SubjectFolder);
Runs = Runs(3:end);
Runs = {Runs.name};
[s,v] = listdlg('PromptString','Select a file: or cancel for Random',...
                'SelectionMode','single',...
                'ListString',Runs);
if v==0
    s = Runs(randi(numel(Runs)));
else 
    s = Runs(s);
end

RunFolder = fullfile(SubjectFolder,s{1});

Trials =  dir(RunFolder);
Trials= {Trials.name};
Trials = Trials(endsWith(Trials,'img'));
FirstTrial = Trials{1};
LastTrial = Trials{end};
temp = strfind(FirstTrial,'-');
templast = strfind(LastTrial,'-');
FirstTrial = str2num(FirstTrial(temp(end)-3:temp(end)-1));
LastTrial = str2num(LastTrial(templast(end)-3:templast(end)-1));
Dlg = sprintf('Please select a Trial Number from %03d to %03d or Enter 0 for Random selection', FirstTrial,LastTrial);
Trial = inputdlg(Dlg);
Trial = Trial{:};

if Trial == 0 
    Trial = randi([FirstTrial,LastTrial]);
end

Trial = Trials{Trial};

TrialFile = fullfile(RunFolder,Trial);

spm_check_registration(TrialFile) 