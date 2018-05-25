%       Script modified from John Ashburner's 08/08/2005 post to JISCMAIL
%            Written by Alastair Reid 22/09/2005
%
%            Script to generate total grey matter volumes (in ml) from modulated
%            segmented images (mwc1*.img)
%
%            Note: have to specify own vbmdir and img_dir to suit
%

spm_defaults
global defaults
%% Number of subjects
nsub=30;

%% Directory in which processing occurs
vbmdir='~/data1/users/bgold/GROUP_ANLYSIS/STRUCTURAL/GM_images/';

%%  Load images volumes
P=spm_select(nsub,'any','Select Modulated Images','',vbmdir,'.img','');

%% Name of output file
logname = 'grey_volumes.txt';

if exist(logname,'file');
    %fid = fopen(logname,'a');
    %else
    fprintf('\ndeleting existing grey_volumes.txt\n');
    rm grey_volumes.txt;
    fid = fopen(logname,'w');
    %fprintf(fid,'Volume [ml]\tgray');
end


fprintf('\n\n Calculating global tissue volumes for each subject...\n ');
fprintf('\n Global grey matter volume ml for each subject...\n ');
img_dir='data1/users/bgold/GROUP_ANLYSIS/STRUCTURAL/GM_images/';
for sub = 30:nsub
    
    Q = deblank(P(sub,:));
    [pth,nm,xt,vr] = fileparts(deblank(Q));
    U = fullfile([vbmdir img_dir],['' nm '' xt vr]);
    V = spm_vol(U);
    vol=0;
    voxvol=0;
    for z=1:V.dim(3)
        img=spm_slice_vol(V,spm_matrix([0 0 z]),V.dim(1:2),0);
        img=img(finite(img));
        vol=vol+sum(img(:));
    end
    voxvol=abs(det(V.mat(1:3,1:3)))*1e-6;
    fprintf('%g voxels, %g mlitres\n',vol,1000*vol*voxvol);
    fprintf(fid,'\t%5.3f',1000*vol*voxvol);
    % fprintf ('%g',volml)
    
    fprintf('\n');
end