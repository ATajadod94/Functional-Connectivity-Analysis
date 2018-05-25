%-----------------------------------------------------------------------
% Alireza Tajadod 
%-----------------------------------------------------------------------
%%

HomeName = 'phdThesisData';
%Assumuing we're in the scripts folder as we should be running this script 
CurrentDirectory = pwd;

%The subjects folder should always be in the root directory of the Scripts 
HomeDirectory = strcat(CurrentDirectory(1:strfind(CurrentDirectory,HomeName)-1),HomeName);
RawData = strcat(HomeDirectory,'/Data/Raw_Data');

%Preprocess folder
OutputDirectory = strcat(HomeDirectory,'/Data/PreProcess/');


AllSubjects = dir(RawData);
AllSubjects = AllSubjects(~ismember({AllSubjects.name},{'.','..'}));





%loop Subjects
for i=[10,11] %length(AllSubjects)
    display(AllSubjects(i).name);
 
    
    SubjectDirecotry = strcat(RawData,'/',AllSubjects(i).name,...
        '/','scans','/');
    Alldata = dir(SubjectDirecotry);
    Alldata = Alldata(3:end);

    %Loop Runs 
    for j=1:length(Alldata)
        clear files
        MyOutput = strcat(OutputDirectory, AllSubjects(i).name,'/', Alldata(j).name);
        mkdir(MyOutput);
        
        MyData = Alldata(j);
        MyDirectory = strcat(SubjectDirecotry,MyData.name,'/DICOM');
        allfile = dir(MyDirectory);
        allfile = allfile([allfile.isdir] ~= 1);
        for m=1:length(allfile)
            files{m} = fullfile(MyDirectory,allfile(m).name);
        end
        matlabbatch{1}.spm.util.dicom.data = files;
        
        matlabbatch{1}.spm.util.dicom.root = 'flat';
        matlabbatch{1}.spm.util.dicom.outdir = {MyOutput};
        matlabbatch{1}.spm.util.dicom.convopts.format = 'img';
        matlabbatch{1}.spm.util.dicom.convopts.icedims = 0;
        
        spm('defaults', 'FMRI');
        spm_jobman('serial', matlabbatch);
     end
end


