cd 'path/Inflated/subjects';
Subs = dir('*subjectname');

labelslh = {'1_LH_V1.label' '2_LH_V1.label' '3_LH_V1.label' '4_LH_V1.label' '5_LH_V1.label'...
    '6_LH_V1.label' '7_LH_V1.label' '8_LH_V1.label' '9_LH_V1.label'};


for j=1:length(labelslh)
    for i=1:length(Subs)
       
        eval(['! mri_label2label --srcsubject fsaverage --srclabel fsaverage/label/' labelslh{j}...
            ' --trgsubject ' Subs(i).name ' --trglabel ' Subs(i).name '/label/' labelslh{j} ...
            ' --regmethod surface --hemi lh'])
     
    end
end

%For right hemi:

labelsrh = {'1_RH_V1.label' '2_RH_V1.label' '3_RH_V1.label' '4_RH_V1.label' '5_RH_V1.label'...
    '6_RH_V1.label' '7_RH_V1.label' '8_RH_V1.label' '9_RH_V1.label'};


for j=1:length(labelsrh)
    for i=1:length(Subs)
       
        eval(['! mri_label2label --srcsubject fsaverage --srclabel fsaverage/label/' labelsrh{j}...
            ' --trgsubject ' Subs(i).name ' --trglabel ' Subs(i).name '/label/' labelsrh{j} ...
            ' --regmethod surface --hemi rh'])
     
    end
end


