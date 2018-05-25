function [] = makelabels(subject,lbound,ubound,VCregion,parcel)
lhstats = MRIread([subject '/surf/lh.V1-3.ecctmp.sym.mgh']);
rhstats = MRIread([subject '/surf/rh.V1-3.ecctmp.sym.mgh']);

%% determine the vertices with ecct values between lbound and ubound
lheccenvertexlist = findvertexnums(lhstats,lbound,ubound);
rheccenvertexlist = findvertexnums(rhstats,lbound,ubound);
if size(rheccenvertexlist,2) > 1
    lheccenvertexlist = lheccenvertexlist';
    rheccenvertexlist = rheccenvertexlist';
end

%% find the vertices in their V? label file. need to do for both lh and
% rh. copy all info for each desired vertex and put into matrix. use
% this matrix to make our own label file
if strcmp(VCregion,'V1')
    if strcmp(parcel,'Glasser')
        lhl = read_label(subject,'lh.L_V1_ROI_ext');
        rhl = read_label(subject,'rh.R_V1_ROI_ext');
    elseif strcmp(parcel,'freesurfer')
        lhl = read_label(subject,'lh.V1_exvivo.thresh');
        rhl = read_label(subject,'rh.V1_exvivo.thresh');
    end
elseif strcmp(VCregion,'V2')
    if strcmp(parcel,'Glasser')
        lhl = read_label(subject,'lh.L_V2_ROI_ext');
        rhl = read_label(subject,'rh.R_V2_ROI_ext');
    elseif strcmp(parcel,'freesurfer')
        lhl = read_label(subject,'lh.V2_exvivo.thresh');
        rhl = read_label(subject,'rh.V2_exvivo.thresh');
    end
elseif strcmp(VCregion,'V3')
    if strcmp(parcel,'Glasser')
        lhl = read_label(subject,'lh.L_V3_ROI_ext');
        rhl = read_label(subject,'rh.R_V3_ROI_ext');
    elseif strcmp(parcel,'freesurfer')
        disp('Freesurfer has no V3 labels. Can comment that command out')
    end
else
    error('Incompatible visual cortex area')
end

% Set up the x,y,z coordinate spots for each vertex plus the 5th column
% which will be all zeros.
lheccenvertexlist(:,2:5) = 0;
rheccenvertexlist(:,2:5) = 0;

lheccenvertexlist = getvertex_xyz(lheccenvertexlist,lhl);
rheccenvertexlist = getvertex_xyz(rheccenvertexlist,rhl);

if isempty(lheccenvertexlist)
    disp([subject ' LH ' VCregion ' ' num2str(lbound) ' to ' num2str(ubound) ' is empty'])
else
    %% make label files for lh with eccentricity lbound to ubound
    if strcmp(parcel,'freesurfer')
        foldername = [subject '/label/FSecc'];
    else
        foldername = [subject '/label/Glasserecc'];
    end
    
    if ~exist(foldername,'dir')
        mkdir(foldername)
    end
    
    if strcmp(VCregion,'V1')
        write_label(lheccenvertexlist(:,1),lheccenvertexlist(:,2:4),lheccenvertexlist(:,5),[foldername '/LH_V1_' num2str(lbound) 'to' num2str(ubound) '.label'],subject);
    elseif strcmp(VCregion,'V2')
        write_label(lheccenvertexlist(:,1),lheccenvertexlist(:,2:4),lheccenvertexlist(:,5),[foldername '/LH_V2_' num2str(lbound) 'to' num2str(ubound) '.label'],subject);
    else
        write_label(lheccenvertexlist(:,1),lheccenvertexlist(:,2:4),lheccenvertexlist(:,5),[foldername '/LH_V3_' num2str(lbound) 'to' num2str(ubound) '.label'],subject);
    end
end

if isempty(rheccenvertexlist)
    disp([subject ' RH ' VCregion ' ' num2str(lbound) ' to ' num2str(ubound) ' is empty'])
else
    %% make label files for rh with eccentricity lbound to ubound
    if strcmp(parcel,'freesurfer')
        foldername = [subject '/label/FSecc'];
    else
        foldername = [subject '/label/Glasserecc'];
    end
    
    if ~exist(foldername,'dir')
        mkdir(foldername)
    end
    
    if strcmp(VCregion,'V1')
        write_label(rheccenvertexlist(:,1),rheccenvertexlist(:,2:4),rheccenvertexlist(:,5),[foldername '/RH_V1_' num2str(lbound) 'to' num2str(ubound) '.label'],subject);
    elseif strcmp(VCregion,'V2')
        write_label(rheccenvertexlist(:,1),rheccenvertexlist(:,2:4),rheccenvertexlist(:,5),[foldername '/RH_V2_' num2str(lbound) 'to' num2str(ubound) '.label'],subject);
    else
        write_label(rheccenvertexlist(:,1),rheccenvertexlist(:,2:4),rheccenvertexlist(:,5),[foldername '/RH_V3_' num2str(lbound) 'to' num2str(ubound) '.label'],subject);
    end
end
end

%% Find vertices with eccentricities between lbound and ubound
function [vertexlist] = findvertexnums(hstats, lbound, ubound)
vertexlist = [];
for vertexnum = 1:length(hstats.vol)-1
    if (hstats.vol(vertexnum+1) <= ubound && hstats.vol(vertexnum+1) >= lbound)
        vertexlist(end+1,1) = vertexnum;
    end
end

end

%% find the x,y,and z position of each vertex for our label
function eccenvertexlist = getvertex_xyz(eccenvertexlist,hl)
for ii = 1:length(eccenvertexlist)
    if(isempty(hl(eccenvertexlist(ii,1)==hl(:,1),2)))
        eccenvertexlist(ii,:) = NaN;
    else
        eccenvertexlist(ii,2) = hl(eccenvertexlist(ii,1)==hl(:,1),2);
        eccenvertexlist(ii,3) = hl(eccenvertexlist(ii,1)==hl(:,1),3);
        eccenvertexlist(ii,4) = hl(eccenvertexlist(ii,1)==hl(:,1),4);
        eccenvertexlist(ii,5) = hl(eccenvertexlist(ii,1)==hl(:,1),5);
    end
end
eccenvertexlist(isnan(eccenvertexlist(:,2)),:)=[];

end