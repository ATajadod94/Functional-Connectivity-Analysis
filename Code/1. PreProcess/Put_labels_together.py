import os

def listdir_fullpath(d):
    return [os.path.join(d, f) for f in os.listdir(d)]

os.chdir('/Volumes/Ryan3T1/myStudies/phdThesisData/Data')

subject = '1'#input('Subject Number?')

Hippo_temp = listdir_fullpath(os.path.join('FreeSurfer_ROIs',subject.zfill(2),'Ali_ROIs'));
Griffis = listdir_fullpath(os.path.join('griffisV1_zx',subject.zfill(2)));
Glasser_temp = listdir_fullpath(os.path.join('glasser_label',subject.zfill(2)));
Kastner_temp = listdir_fullpath(os.path.join('PreProcess','Subject_' + subject.zfill(2), 'Kastner_label'))
Localizer_temp = listdir_fullpath(os.path.join('PreProcess','Subject_' + subject.zfill(2), 'Localizer_Label'))
Glasser = [s for s in Glasser_temp if s.endswith('.nii')]
Localizer = [s for s in Localizer_temp if s.endswith('.img')]
Hippo_full = [s for s in Hippo_temp if 'r__venstrea' in s or 'l__venstrea' in s]
Hippo_new = [s for s in Hippo_temp if 'fusi_head' in s or 'entro' in s]
Kastner = [s for s in Kastner_temp if '25' in s or 'FEF' in s]



for idx,item in map(Image,Hippo):
	overlayList.append(item)
for item in map(Image,Griffis):
	overlayList.append(item)
for item in map(Image,Kastner):
	overlayList.append(item)
for item in map(Image,Glasser):
	overlayList.append(item)
for item in map(Image,Localizer):
	overlayList.append(item)


for overlay in overlayList:
	display = displayCtx.getDisplay(overlay)
	opts    = displayCtx.getOpts(overlay)
	opts.cmap          = 'random'

