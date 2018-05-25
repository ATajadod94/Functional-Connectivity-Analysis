load('MySubjects.mat')
fields = fieldnames(MySubjects);
for i=1:numel(fields)

    location = MySubjects.(fields{i}).Anatomy.Filename;
    allimages = dir(location);
    imagenames = {allimages.name};
    myimage = imagenames(12);
    imageloc = fullfile(location,myimage);
    [Data, Head] = rest_ReadNiftiImage(imageloc{:});

    folder= fullfile('/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess/Anatomy_Nifti',fields(i));
    mkdir(folder{:})
    copyfile(imageloc{:},folder{:})
    outdir = fullfile(folder,'001.nii');
    rest_WriteNiftiImage(Data, Head,[outdir{:}]);
    
    
end