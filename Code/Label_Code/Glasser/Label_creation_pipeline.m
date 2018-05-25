function [] = NL_thickness_Glasser()
%% Folder setup
% Set the subjects directory environmental variable for freesurfer. This is
% where your Freesurfer output subject folders are from the recon-all
setenv('SUBJECTS_DIR','/Users/Ali/Desktop/Baycrest/Data')
setenv('FREESURFER_HOME','/Applications/freesurfer')
cd(getenv('SUBJECTS_DIR'))

% These commands get the names of the subjects in your SUBJECTS_DIR. All of
% my folders had subj###. Replace subj* with a general identifier common to
% your subjects
folders = dir();
Subs = {folders(5).name};
%% Xhemi setup. 
% Run as a parfor loop is possible. This done so that the Benson
% retinotopic atlas can be transferred to both hemispheres (lh and rh).
% This process will take at least an hour per subject

parfor SubID = 1:length(Subs)
    system(['surfreg --s ' Subs{SubID} ' --t fsaverage_sym --lh']);
    system(['surfreg --s ' Subs{SubID} ' --t fsaverage_sym --lh --xhemi']);
end

%% Map fsaverage_sym eccentricity atlas onto lh and xhemi lh (rh) for each subject. 
% Moved resulting map into subject's surf folder. Don't make into parfor.
% Have the polar angle and eccentricity atlases in the SUBJECTS_DIR or give
% it the path to those files in the --sval flag

for SubID = 1:length(Subs)
    % transfer polar angle map to individual subjects
    system(['mri_surf2surf --srcsubject fsaverage_sym --srcsurfreg sphere.reg --trgsubject ' Subs{SubID} ' --trgsurfreg fsaverage_sym.sphere.reg --hemi lh --sval angle-template.sym.mgh --tval lh.V1-3.anglemp.sym.mgh'])
    system(['mri_surf2surf --srcsubject fsaverage_sym --srcsurfreg sphere.reg --trgsubject ' Subs{SubID} '/xhemi --trgsurfreg fsaverage_sym.sphere.reg --hemi lh --sval angle-template.sym.mgh --tval rh.V1-3.anglemp.sym.mgh'])
    
    movefile('lh.V1-3.anglemp.sym.mgh',[Subs{SubID} '/surf'])
    movefile('rh.V1-3.anglemp.sym.mgh',[Subs{SubID} '/surf'])
    
    %transfer eccentricity map to individual subjects
    system(['mri_surf2surf --srcsubject fsaverage_sym --srcsurfreg sphere.reg --trgsubject ' Subs{SubID} ' --trgsurfreg fsaverage_sym.sphere.reg --hemi lh --sval eccen-template.sym.mgh --tval lh.V1-3.ecctmp.sym.mgh'])
    system(['mri_surf2surf --srcsubject fsaverage_sym --srcsurfreg sphere.reg --trgsubject ' Subs{SubID} '/xhemi --trgsurfreg fsaverage_sym.sphere.reg --hemi lh --sval eccen-template.sym.mgh --tval rh.V1-3.ecctmp.sym.mgh'])
    
    movefile('lh.V1-3.ecctmp.sym.mgh',[Subs{SubID} '/surf'])
    movefile('rh.V1-3.ecctmp.sym.mgh',[Subs{SubID} '/surf'])
end


%% Transfer Glasser V1,V2,and V3 extended labels from fsaverage to each subject
% transforms desired ROI labels from fsaverage space to subject space and
% stores them in the subject's label folder

% If you are using the freesurfer V1 and V2 labels instead, you don't need
% to do this part
lhlabellist = dir('fsaverage/label/*lh.L_V*_ROI*_ext*');
rhlabellist = dir('fsaverage/label/*rh.R_V*_ROI*_ext*');
for SubID = 1:length(Subs)
    for labelnum = 1:length(rhlabellist)
        system(['mri_label2label --srcsubject fsaverage --srclabel fsaverage/label/' lhlabellist(labelnum).name ' --trgsubject ' Subs{SubID} ' --trglabel ' Subs{SubID} '/label/' lhlabellist(labelnum).name ' --regmethod surface --hemi lh'])
        system(['mri_label2label --srcsubject fsaverage --srclabel fsaverage/label/' rhlabellist(labelnum).name ' --trgsubject ' Subs{SubID} ' --trglabel ' Subs{SubID} '/label/' rhlabellist(labelnum).name ' --regmethod surface --hemi rh'])
    end
end

%% subdivide V1, V2, and V3 ROIs in each subject
%  the eccentricity ranges are 0.5to1.5, 1.5to3, 3to5, 5to8, 8to12,
%  12to18, 18to28, and 28to50. The range goes from lbound(ii) to ubound(ii)
%  The last argument chooses which base label to divide, either the Glasser
%  labels or the freesurfer labels. The freesurfer labels only have V1 and
%  V2 so comment out the line for V3.
lbound = [0.5, 1.5,   3,    5,    8,  12,   18,   28];
ubound = [1.5,   3,   5,    8,   12,  18,   28,   50];

parfor SubID = 1:length(Subs)
    for ii = 1:length(lbound)
        makelabels(Subs{SubID},lbound(ii),ubound(ii),'V1','freesurfer')
        %makelabels(Subs{SubID},lbound(ii),ubound(ii),'V2','freesurfer')
        %makelabels(Subs{SubID},lbound(ii),ubound(ii),'V3','Glasser')
    end
end

end
