function display_slices(imgs, dispf)
% FORMAT display_slices(imgs, dispf)
%
% request a some parameters for slice_overlay routine
% while accepting many defaults
% SO structure contains all the parameters for display
% See slice_overlay.m for detailed comments
%
% Defaults to GUI if no arguments passed
% imgs  - string or cell array of image names to display
% dispf - flag, if set, displays overlay (default = 1)
%
% Matthew Brett 5/00 V 0.3
 
if nargin < 1
  imgs = spm_get(Inf, 'img', 'Image(s) to display');
end
if ischar(imgs)
  imgs = cellstr(imgs);
end
if nargin < 2
  dispf = 1;
end
  
clear global SO
global SO  

spm_input('!SetNextPos', 1);

% load images
nimgs = size(imgs);

% process names
nchars = 20;
imgns = spm_str_manip(imgs, ['rck' num2str(nchars)]);

% identify image types
cscale = [];
deftype = 1;
SO.cbar = [];
for i = 1:nimgs
  SO.img(i).vol = spm_vol(imgs{i});
  options = {'Structural','Truecolour', ...
	     'Blobs','Negative blobs'};
  % if there are SPM results in the workspace, add this option
  if evalin('base','exist(''SPM'', ''var'')')
    options = {'Structural with SPM blobs', options{:}};
  end
  itype = spm_input(sprintf('Img %d: %s - image type?', i, imgns{i}), '+1', ...
		    'm', char(options),options, deftype);
  imgns(i) = {sprintf('Img %d (%s)',i,itype{1})};
  [mx mn] = slice_overlay('volmaxmin', SO.img(i).vol);
  if ~isempty(strmatch('Structural', itype))
    SO.img(i).cmap = gray;
    SO.img(i).range = [mn mx];
    deftype = 2;
    cscale = [cscale i];
    if strcmp(itype,'Structural with SPM blobs')
      errstr = sprintf(['Cannot find SPM/VOL structs in the workspace\n'...
		       'Please run SPM results GUI before' ...
			' display_slices']);
      SPM = evalin('base', 'SPM', ['error(' errstr ')']);
      VOL = evalin('base', 'VOL', ['error(' errstr ')']);
      slice_overlay('addspm',SPM,VOL,0);
    end
  else
    SO.cbar = [SO.cbar i];
    cprompt = ['Colormap: ' imgns{i}];
    switch itype{1}
     case 'Truecolour'
      dcmap = 'actc';
      drange = [mn mx];
      cscale = [cscale i];
     case 'Blobs'
      dcmap = 'hot';
      drange = [0 mx];
      SO.img(i).prop = Inf;
     case 'Negative blobs'
      dcmap = 'winter';
      drange = [0 mn];
      SO.img(i).prop = Inf;
    end
    SO.img(i).cmap = return_cmap(cprompt, dcmap);
    SO.img(i).range = spm_input('Img val range for colormap','+1', 'e', drange, 2);
  end
end
ncmaps=length(cscale);
if ncmaps == 1
  SO.img(cscale).prop = 1;
else
  remcol=1;
  for i = 1:ncmaps
    ino = cscale(i);
    SO.img(ino).prop = spm_input(sprintf('%s intensity',imgns{ino}),...
				 '+1', 'e', ...
				 remcol/(ncmaps-i+1),1);
    remcol = remcol - SO.img(ino).prop;
  end
end
 
SO.transform = deblank(spm_input('Image orientation', '+1', ['Axial|' ...
		    ' Coronal|Sagittal'], strvcat('axial','coronal','sagittal'), ...
		    1));

% use SPM figure window
SO.figure = spm_figure('GetWin', 'Graphics'); 

% slices for display
slice_overlay('checkso');
SO.slices = spm_input('Slices to display (mm)', '+1', 'e', ...
		      sprintf('%0.0f:%0.0f:%0.0f',...
			      SO.slices(1),...
			      mean(diff(SO.slices)),...
			      SO.slices(end))...
		      );

% and do the display
if dispf
  slice_overlay
end
return

function cmap = return_cmap(prompt,defmapn)
cmap = [];
while isempty(cmap)
  cmap = slice_overlay('getcmap', spm_input(prompt,'+1','s', defmapn));
end
return