%-----------------------------------------------------------------------
% Alireza Tajadod
%-----------------------------------------------------------------------


clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MySubjects = struct;
MySubjects.Subject_01 = struct;
MySubjects.Subject_02 = struct;
MySubjects.Subject_03 = struct;
MySubjects.Subject_04 = struct;
MySubjects.Subject_05 = struct;
MySubjects.Subject_06 = struct;
MySubjects.Subject_07 = struct;
MySubjects.Subject_08 = struct;
MySubjects.Subject_09 = struct;
MySubjects.Subject_10 = struct;
MySubjects.Subject_11 = struct;
MySubjects.Subject_12 = struct;
MySubjects.Subject_13 = struct;
MySubjects.Subject_14 = struct;
MySubjects.Subject_15 = struct;
MySubjects.Subject_16 = struct;
MySubjects.Subject_17 = struct;
MySubjects.Subject_18 = struct;
MySubjects.Subject_19 = struct;
MySubjects.Subject_20 = struct;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HomeName = 'phdThesisData';
CurrentDirectory = pwd;
HomeDirectory = strcat(CurrentDirectory(1:strfind(CurrentDirectory,HomeName)-1),HomeName);

fields = fieldnames(MySubjects);
for i=1:numel(fields)
     MySubjects.(fields{i}).Folder = fullfile(HomeDirectory,'Data','PreProcess',fields{i});
end


RunNames =   {  'preencoding_rest'
                'encoding_fam1'
                'encoding_fam2'
                'post_encoding_rest_fam'
                'encoding_nonfam1'
                'encoding_nonfam2'
                'post_encoding_rest_nonfam'
                'localizer_task'
                'thinkback'
                'thinkahead' };
OrgFileNames = {
                        '4_OB-AX  ep2d_bold ~184~Pre'
                        '5_OB-AX  ep2d_bold ~ 290'
                        '6_OB-AX  ep2d_bold ~ 290'
                        '7_OB-AX  ep2d_bold ~184~Post 1'
                        '8_OB-AX  ep2d_bold ~ 290'
                        '9_OB-AX  ep2d_bold ~ 290'
                        '10_OB-AX  ep2d_bold ~184~Post 2'
                        '11_OB-AX  ep2d_bold ~ 292'
                        '12_OB-AX  ep2d_bold ~184~Post 3 ~Task'
                        '13_OB-AX  ep2d_bold ~184~Post 4~Task'
                        '3_T1 MPRAGE OB-AXIAL'
                  }  ;

for i=1:numel(fields)
    MySubjects.(fields{i}).Runs.NameChanges = cell(10,1);
    Position = 1;
     MySubjects.(fields{i}).Anatomy.OrgFileName = fullfile(MySubjects.(fields{i}).Folder,OrgFileNames(11));
     MySubjects.(fields{i}).Anatomy.Filename = fullfile(MySubjects.(fields{i}).Folder,'Anatomy');
        MySubjects.(fields{i}).Anatomy.Image =  (dir(MySubjects.(fields{i}).Anatomy.OrgFileName{:}));
        MySubjects.(fields{i}).Anatomy.Image =  fullfile(MySubjects.(fields{i}).Anatomy.Filename,MySubjects.(fields{i}).Anatomy.Image(4).name);
               % py.os.rename(MySubjects.(fields{i}).Anatomy.OrgFileName{:},MySubjects.(fields{i}).Anatomy.Filename)

    for j=1:numel(RunNames)
        if mod(i,2) == 0
            if Position == 2
                Position = 5;
            elseif Position == 8
                Position = 2;
            elseif Position == 5
                Position = 8;
            end
        end
        if ismember(i,[3,4,7,8,11,12,15,16,19,20])
            if Position == 9
                Position = 10;
            elseif Position == 11
                Position =9;
            end
        end

        MySubjects.(fields{i}).Runs.(RunNames{j}).Position = Position;
        MySubjects.(fields{i}).Runs.(RunNames{j}).Folder = fullfile(MySubjects.(fields{i}).Folder,RunNames{j});
        MySubjects.(fields{i}).Runs.(RunNames{j}).OrgFileName = fullfile(OrgFileNames( MySubjects.(fields{i}).Runs.(RunNames{j}).Position));
        MySubjects.(fields{i}).Runs.(RunNames{j}).OldFolder = fullfile(MySubjects.(fields{i}).Folder,OrgFileNames( MySubjects.(fields{i}).Runs.(RunNames{j}).Position));


        allfile = dir(MySubjects.(fields{i}).Runs.(RunNames{j}).OldFolder{:});
        allfile = allfile([allfile.isdir] ~= 1);
		allfile = allfile(7:end);
        l = 1;
        for m=2:2:length(allfile)
		          MySubjects.(fields{i}).Runs.(RunNames{j}).Images{l} = fullfile(MySubjects.(fields{i}).Runs.(RunNames{j}).Folder,allfile(m).name);
                  l = l+1;
        end

        py.os.rename(MySubjects.(fields{i}).Runs.(RunNames{j}).OldFolder{:},MySubjects.(fields{i}).Runs.(RunNames{j}).Folder)

        Trials= allfile;
        Trials= {Trials.name};
        FirstTrial = Trials{1};
        LastTrial = Trials{end};
        temp = strfind(FirstTrial,'-');
        MySubjects.(fields{i}).Runs.(RunNames{j}).FirstTrial = str2num(FirstTrial(temp(end)-3:temp(end)-1));
        MySubjects.(fields{i}).Runs.(RunNames{j}).LastTrial = str2num(LastTrial(temp(end)-3:temp(end)-1));

        Position = Position+1;
        MySubjects.(fields{i}).Runs.NameChanges(Position-1) = cellstr(RunNames{j});

    end

end



save('MySubjects');
