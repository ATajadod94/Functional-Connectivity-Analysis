function TabDat = spm_VOI_Custom(SPM,xSPM,hReg,CustomParams)
% Custom variant of SPM5's function to allow greater customisation.
% All custom parameters are optional, and are defined in the CustomParams
% Struct:
% Num = 16 - maxima per cluster
% Dis = 4  - distance among maxima (mm)
% xyzmm    - mm coordinates (GUI input if undefined) NB column vector!
% SPACE = S- shape of VOI (S for sphere, B for box, I for image)
% D        - mm radius for sphere, xyz dimensions for box, path for image.
% 	(GUI input if undefined)
% To use, first bring up some results in SPM to obtain the necessary
% SPM, xSPM and hReg inputs.
% 5/1/2010 J Carlin

% List of local maxima and adjusted p-values for a small Volume of Interest
% FORMAT TabDat = spm_VOI(SPM,xSPM,hReg,[CustomParams])
%
% SPM   - structure containing analysis details (see spm_spm)
%
% xSPM  - structure containing SPM, distribution & filtering details
%        - required fields are:
% .swd   - SPM working directory - directory containing current SPM.mat
% .Z     - minimum of n Statistics {filtered on u and k}
% .n     - number of conjoint tests
% .STAT  - distribution {Z, T, X or F}
% .df    - degrees of freedom [df{interest}, df{residual}]
% .u     - height threshold
% .k     - extent threshold {resels}
% .XYZ   - location of voxels {voxel coords}
% .XYZmm - location of voxels {mm}
% .S     - search Volume {voxels}
% .R     - search Volume {resels}
% .FWHM  - smoothness {voxels}
% .M     - voxels - > mm matrix
% .VOX   - voxel dimensions {mm}
% .DIM   - image dimensions {voxels} - column vector
% .Vspm  - Mapped statistic image(s)
% .Ps    - P vlues in searched voxels (for FDR)
%
% hReg   - Handle of results section XYZ registry (see spm_results_ui.m)
%
% TabDat - Structure containing table data
%        - see spm_list for definition
%
%_______________________________________________________________________
%
% spm_VOI is  called by the SPM results section and takes variables in
% SPM to compute p-values corrected for a specified volume of interest.
%
% The volume of interest may be defined as a box or sphere centred on
% the current voxel or by a mask image.
%
% If the VOI is defined by a mask this mask must have been defined
% independently of the SPM (e.g.using a mask based on an orthogonal
% contrast)
%
% External mask images should be in the same orientation as the SPM
% (i.e. as the input used in stats estimation). The VOI is defined by
% voxels with values greater than 0.
%
% FDR computations are similarly resticted by the small search volume
%
% See also: spm_list
%_______________________________________________________________________
% Copyright (C) 2005 Wellcome Department of Imaging Neuroscience

% Karl Friston
% $Id: spm_VOI.m 1770 2008-06-01 01:01:12Z Darren $


%-Parse arguments
%-----------------------------------------------------------------------
if nargin < 2,   error('insufficient arguments'), end
if nargin < 3,	 hReg = []; end
if nargin < 4, CustomParams = struct; end

if ~isfield(CustomParams,'Num'), CustomParams.Num = 16; end
if ~isfield(CustomParams,'Dis'), CustomParams.Dis = 4; end

%Num      = 16;			% maxima per cluster
%Dis      = 04;			% distance among maxima (mm)

%-Title
%-----------------------------------------------------------------------
spm('FigName',['SPM{',xSPM.STAT,'}: Small Volume Correction']);

%-Get current location {mm}
%-----------------------------------------------------------------------
%xyzmm    = spm_results_ui('GetCoords');
if ~isfield(CustomParams,'xyzmm')
	CustomParams.xyzmm = spm_results_ui('GetCoords');
else
	CustomParams.xyzmm = reshape(CustomParams.xyzmm,3,1); % Ensure row vector
end

%-Specify search volume
%-----------------------------------------------------------------------
str      = sprintf(' at [%.0f,%.0f,%.0f]',CustomParams.xyzmm(1),CustomParams.xyzmm(2),CustomParams.xyzmm(3));

if ~isfield(CustomParams,'SPACE')
	CustomParams.SPACE = spm_input('Search volume...',-1,'m',...
		{['Sphere',str],['Box',str],'Image'},['S','B','I']);
end

% voxels in entire search volume {mm}
%-----------------------------------------------------------------------
XYZmm    = SPM.xVol.M(1:3,:)*[SPM.xVol.XYZ; ones(1, SPM.xVol.S)];
Q        = ones(1,size(xSPM.XYZmm,2));
O        = ones(1,size(     XYZmm,2));
FWHM     = xSPM.FWHM;


switch CustomParams.SPACE

	case 'S' %-Sphere
	%---------------------------------------------------------------
	if ~isfield(CustomParams,'D')
		CustomParams.D          = spm_input('radius of VOI {mm}',-2);
	end

	str        = sprintf('%0.1fmm sphere',CustomParams.D);
	j          = find(sum((xSPM.XYZmm - CustomParams.xyzmm*Q).^2) <= CustomParams.D^2);
	k          = find(sum((     XYZmm - CustomParams.xyzmm*O).^2) <= CustomParams.D^2);
	CustomParams.D          = CustomParams.D./xSPM.VOX;


	case 'B' %-Box
	%---------------------------------------------------------------
	if ~isfield(CustomParams,'D')
		CustomParams.D          = spm_input('box dimensions [k l m] {mm}',-2);
	end

    if length(CustomParams.D)~=3, CustomParams.D = ones(1,3)*CustomParams.D(1); end
	str        = sprintf('%0.1f x %0.1f x %0.1f mm box',CustomParams.D(1),CustomParams.D(2),CustomParams.D(3));
	j          = find(all(abs(xSPM.XYZmm - CustomParams.xyzmm*Q) <= CustomParams.D(:)*Q/2));
	k          = find(all(abs(     XYZmm - CustomParams.xyzmm*O) <= CustomParams.D(:)*O/2));
	CustomParams.D          = CustomParams.D./xSPM.VOX;


	case 'I' %-Mask Image
	%---------------------------------------------------------------
	if ~isfield(CustomParams,'D')
		Msk   = spm_select(1,'image','Image defining search volume');
    else
        Msk   = CustomParams.D; %zhongxu added
	end

	CustomParams.D     = spm_vol(Msk);
	str   = sprintf('image mask: %s',spm_str_manip(Msk,'a30'));
    
    % fix up string so tex interpreter works correctly
    str   = strrep(str,'\','\\');
    str   = strrep(str,'_','\_');
    str   = strrep(str,'^','\^');
    str   = strrep(str,'{','\{');
    str   = strrep(str,'}','\}');
    
	VOX   = sqrt(sum(CustomParams.D.mat(1:3,1:3).^2));
	FWHM  = FWHM.*(xSPM.VOX./VOX);
	XYZ   = CustomParams.D.mat \ [xSPM.XYZmm; ones(1, size(xSPM.XYZmm, 2))];
	j     = find(spm_sample_vol(CustomParams.D, XYZ(1,:), XYZ(2,:), XYZ(3,:),0) > 0);
	XYZ   = CustomParams.D.mat \ [     XYZmm; ones(1, size(    XYZmm, 2))];
	k     = find(spm_sample_vol(CustomParams.D, XYZ(1,:), XYZ(2,:), XYZ(3,:),0) > 0);

end

xSPM.S     = length(k);
xSPM.R     = spm_resels(FWHM,CustomParams.D,CustomParams.SPACE);
xSPM.Z     = xSPM.Z(j);
xSPM.XYZ   = xSPM.XYZ(:,j);
xSPM.XYZmm = xSPM.XYZmm(:,j);
% xSPM.Ps    = xSPM.Ps(k); %zhongxu comment out, according to spm_VOI.m

%-Restrict FDR to the search volume % zhongxu copied from spm_VOI.m
%--------------------------------------------------------------------------
df         = xSPM.df;
STAT       = xSPM.STAT;
DIM        = xSPM.DIM;
R          = xSPM.R;
n          = xSPM.n;
Z          = xSPM.Z;
u          = xSPM.u;
S          = xSPM.S;

try, xSPM.Ps  = xSPM.Ps(k); end
[up, xSPM.Pp] = spm_uc_peakFDR(0.05,df,STAT,R,n,Z,SPM.xVol.XYZ(:,k),u);
try % if STAT == 'T'
    V2R               = 1/prod(xSPM.FWHM(DIM>1));
    [uc, xSPM.Pc, ue] = spm_uc_clusterFDR(0.05,df,STAT,R,n,Z,SPM.xVol.XYZ(:,k),V2R,u);
catch
    uc                = NaN;
    ue                = NaN;
    xSPM.Pc           = [];
end
uu            = spm_uc(0.05,df,STAT,R,n,S);
xSPM.uc       = [uu up ue uc];

%-Tabulate p values
%-----------------------------------------------------------------------
str       = sprintf('search volume: %s',str);
if any(strcmp(CustomParams.SPACE,{'S','B'}))
	str = sprintf('%s at [%.0f,%.0f,%.0f]',str,CustomParams.xyzmm(1),CustomParams.xyzmm(2),CustomParams.xyzmm(3));
end

TabDat    = spm_list('List',xSPM,hReg,CustomParams.Num,CustomParams.Dis,str);

%-Reset title
%-----------------------------------------------------------------------
spm('FigName',['SPM{',xSPM.STAT,'}: Results']);
