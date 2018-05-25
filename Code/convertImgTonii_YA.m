fdir = dir('F:\myStudies\fixMTL\Faces_Repetiion_fMRI\subj*');

for i = 1:length(fdir)
   datadir =['F:\myStudies\fixMTL\Faces_Repetiion_fMRI\',fdir(i).name,'\anat\'];
   datafile = dir([datadir,'s*.hdr']);
   [a b] = rest_ReadNiftiImage([datadir,datafile.name]);
   outdir = ['F:\myStudies\fixMTL\Faces_Repetiion_fMRI\allAnatForFreeSurfer\10',fdir(i).name(end-1:end)];
   mkdir(outdir);
    rest_WriteNiftiImage(a,b,[outdir,'\001.nii']);
end