import os
from os import listdir
from os.path import isfile, join



DataPath = '/Users/Ali/Desktop/Baycrest/Data'  ## Change for relevant Data Folder
DataPath = os.path.abspath(DataPath)  #For Windows / Mac / Linux
os.environ['SUBJECTS_DIR'] = DataPath;  
os.chdir(DataPath)

Subjects = ['01', '02', '03' ,'04' ,'05' ,'06' ,'07', '08', '09' ,'10', '11' ,'12' ,'13', '14' ,'15', '16' ,'17', '18', '19', '20' ]

subs = []
for i in range(0,len(Subjects)):
    subs.append(join(DataPath,Subjects[i]))



labelslh = ['3_LH_V1.label' ,'5_LH_V1.label' ,'7_LH_V1.label' ,'2_LH_V1.label', '4_LH_V1.label' ,'6_LH_V1.label', '8_LH_V1.label'  ]; 
labelsrh = ['3_RH_V1.label' ,'5_RH_V1.label', '7_RH_V1.label','2_RH_V1.label' ,'4_RH_V1.label','6_RH_V1.label', '8_RH_V1.label'  ]; 



#    for sub in subs:

for labelnum in  labelslh:
        os.system('mri_label2label --srcsubject fsaverage --srclabel fsaverage/label/'  + labelnum + ' --trgsubject ' + Subjects[0] + ' --trglabel ' +  Subjects[0]+ '/label/' + labelnum +  ' --regmethod surface --hemi lh')



for labelnum in  labelsrh:
        os.system('mri_label2label --srcsubject fsaverage --srclabel fsaverage/label/'  + labelnum + ' --trgsubject ' + Subjects[0] + ' --trglabel ' +  Subjects[0]+ '/label/' + labelnum +  ' --regmethod surface --hemi rh')


statsoutfolder = 'StatsOutFolder'
os.makedirs(statsoutfolder)

for labelnum in  labelslh:
        os.system(' /bin/bash mris_anatomical_stats -l ' + labelnum +  ' -f ' + statsoutfolder +  os.path.sep +  Subjects[0] +  '.' +  labelnum  + '.out ' + Subjects[0] +  ' lh')


for labelnum in  labelsrh:
        os.system('mris_anatomical_stats -l ' + labelnum +  ' -f ' + statsoutfolder +  os.path.sep +  Subjects[0] +  '.' +  labelnum  + '.out ' + Subjects[0] +  ' rh')

