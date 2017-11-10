clear;
numsubjects = 1;
addpath(genpath('/Users/Ali/Documents/MATLAB/REST_V1.8_130615'))
subjectdir = '/Users/Ali/Desktop/Baycrest/Data/Post_Free_Label/01';
mkdir('ROIs')
outdir = strcat(subjectdir,'/ROIs');
hippodir = strcat(subjectdir,'/mri/HippRois');
EntoRhinaldir = strcat(subjectdir,'/mri/EntoRhinalRois01');
ParaHippodir = strcat(subjectdir,'/mri/ParaHippocampalRois01');
Fusiformdir =   strcat(subjectdir,'/mri/fusiform01');

for subject=1:numsubjects
    
    %% SUBJECT DEPENDET DATA 
    cd (hippodir)
    lefthippofiles = dir('l*.nii');
    righthippofiles = dir('r*.nii');
    cd (EntoRhinaldir) 
    leftEntoRhinalfiles = dir('l*.nii');
    rightEntoRhinalfiles = dir('r*.nii');
    cd (ParaHippodir)
    leftParaHippofiles = dir('l*.nii');
    rightParaHippofiles = dir('r*.nii');
    cd (Fusiformdir)
    leftFusiformfiles = dir('l*.nii');
    rightFusiformfiles = dir('r.nii');
    cd (outdir);
    sides=['left';'righ'];
    
    





    %%LEFT SIDE / RIHT SIDE
    for side = 1:2
        currentside = sides(side,:);
        %% ================= READ IN DATA ========================%%%
        if strcmp(currentside,'left')
            [hippodata,hippoheader] = rest_ReadNiftiImage(fullfile(lefthippofiles.folder,lefthippofiles.name));
            [entrodata,entroheader] = rest_ReadNiftiImage(fullfile(leftEntoRhinalfiles.folder,leftEntoRhinalfiles.name));
            [paradata,paraheader] =  rest_ReadNiftiImage(fullfile(leftParaHippofiles.folder,leftParaHippofiles.name));
            [fusidata,fusiheader] =  rest_ReadNiftiImage(fullfile(leftFusiformfiles.folder,leftFusiformfiles.name));

            nameprefix = 'l_';
        elseif strcmp(currentside,'righ')
            [hippodata,hippoheader] = rest_ReadNiftiImage(fullfile(lefthippofiles.folder,lefthippofiles.name));
            [entrodata,entroheader] = rest_ReadNiftiImage(fullfile(leftEntoRhinalfiles.folder,leftEntoRhinalfiles.name));
            [paradata,paraheader] =  rest_ReadNiftiImage(fullfile(leftParaHippofiles.folder,leftParaHippofiles.name));
            [fusidata,fusiheader] =  rest_ReadNiftiImage(fullfile(leftFusiformfiles.folder,leftFusiformfiles.name));
            nameprefix = 'r_';
        end
        
     %% SUBJECT DEPENDET VARIABLES 
    affinematrix = hippoheader.private.mat0(1:3,:);
    affineinverse = inv(hippoheader.private.mat0);
    affineinverse = affineinverse(1:3,:);
    
    hippoheader.descrip = 'Ali_Segment';
    entroheader.descrip = 'Ali_Segment';
     paraheader.descrip = 'Ali_Segment';
    fusiheader.descrip = 'Ali_Segment';

    braindims = size(hippodata);
    emptybrain = zeros(braindims);
  
    %% =================  CALCULATE CUT PLANE ========================%%%
    endpoints_voxels = zeros(2,3);
    T1 = find(hippodata,1,'first');
    [i,j,k] = ind2sub(braindims,T1(1));
    endpoints_voxels(1,:) = [i,j,k];
    T1 = find(hippodata,1,'last');
    [i,j,k] = ind2sub(braindims,T1(1));
    endpoints_voxels(2,:) = [i,j,k];
    endpoints_voxels = [endpoints_voxels,[1;1]];
    endpoints_cordinates = affinematrix*endpoints_voxels';
    dirvector = endpoints_cordinates(:,2) - endpoints_cordinates(:,1);
    vectordistance = sqrt(sum(dirvector.^2));
    dirvector = dirvector ./vectordistance;
    cutvector = [-dirvector(3);dirvector(2)];    %% CUT PREPENDICULAR TO YZ PLANE
    
    % myplane returns z for plane on point  p2,p3 preprendicular to 
    % Equations
    %myplane = @(y,p2,p3)    -(dirvector(1)*(y-p2) - (p3*dirvector(2)))/dirvector(2);
    %myplane = @(z,p2,p3)   -(z * dirvector(2) + p3*dirvector(2)  + dirvector(1) * p2 )/dirvector(1);
    myplane =  @(z,inity,initz)  inity+ ((z-initz)/cutvector(2))*cutvector(1);
    distance = @(A,B) abs(sqrt(sum((A-B).^2)));
    
    %% ================= GET MY INTRESTING POINTS ========================%%%
    temp = find(entrodata,2,'last');
    [i,j,k] = ind2sub(braindims,temp(1));
    entroend_voxelpoint = [i,j,k,1];
    entroend_worldpoint = affinematrix*entroend_voxelpoint';
    Hippo_headstart_worldpoint = entroend_worldpoint; %by defenition
    
    temp = find(hippodata,2,'first');
    [i,j,k] = ind2sub(braindims,temp(1));
    hippostart_voxelpoint = [i,j,k,1];
    hippostart_worldpoint = affinematrix*hippostart_voxelpoint';
    Hippo_headend_worldpoint = hippostart_worldpoint; %%by defenition

    temp = find(hippodata,2,'last');
    [i,j,k] = ind2sub(braindims,temp(1));
    hippoend_voxelpoint = [i,j,k,1];
    hippoend_worldpoint = affinematrix*hippoend_voxelpoint';
   
    hippoheadmidpoint = (Hippo_headend_worldpoint+Hippo_headstart_worldpoint)./2;
    Hippo_bodystart_worldpoint = hippoend_worldpoint; %%by defenition
  
    Hippobody_NUMCUTS = 4;
    hippobodydistance = distance( Hippo_bodystart_worldpoint,Hippo_headstart_worldpoint);
    hippocutdistances = linspace(0,hippobodydistance,Hippobody_NUMCUTS+1);
    hippobodycuts = Hippo_headstart_worldpoint + dirvector*hippocutdistances;
    
    % FUSIFROM 
    fusicuts  = [entroend_worldpoint,hippostart_worldpoint,hippoend_worldpoint,hippoheadmidpoint,hippobodycuts];
    [~,idx] = sort(fusicuts,2,'ascend');
    idx = idx(2,:);
    fusicuts = fusicuts(:,idx);
    FUSINUMCUTS = length(fusicuts)+1;
    
    %% ==========SET UP ALL DATA FILES TO BE CUT ========================
    %Hippo data
    hipp_idx = find(hippodata);
    [hippox,hippoy,hippoz] = ind2sub(braindims,hipp_idx);
    hippo_voxel = [hippox,hippoy,hippoz];
    hippo_voxel = [hippo_voxel,ones(length(hippo_voxel),1)];
    hippo_world = affinematrix*hippo_voxel';
    
    %Para data
    para_idx = find(paradata);
    [parax,paray,paraz] = ind2sub(braindims,para_idx);
    para_voxel = [parax,paray,paraz];
    para_voxel = [para_voxel,ones(length(para_voxel),1)];
    para_world = affinematrix*para_voxel';

    %Enro data
    entro_idx = find(entrodata);
    [entrox,entroy, entroz] = ind2sub(braindims,entro_idx);
    entro_voxel = [entrox,entroy,entroz];
    entro_voxel = [entro_voxel,ones(length(entro_voxel),1)];
    entro_world = affinematrix*entro_voxel';
    
    %Fusi data
    fusi_idx = find(fusidata);
    [fusix,fusiy,fusiz] = ind2sub(braindims,fusi_idx);
    fusi_voxel = [fusix,fusiy,fusiz];
    fusi_voxel = [fusi_voxel,ones(length(fusi_voxel),1)];
    fusi_world = affinematrix*fusi_voxel';
    
    %% ================= GET MY CUT PLANES ========================%%%
    hippo_headbody_cutplane = [myplane(hippo_world(3,:),entroend_worldpoint(2),entroend_worldpoint(3));hippo_world(3,:)];
      
      for plane = 1:Hippobody_NUMCUTS+1
        clear temp;
        temp = [myplane(para_world(3,:),hippobodycuts(2,plane),hippobodycuts(3,plane));para_world(3,:)];
        para_cutplane(plane,:,1:length(temp))= temp;
      end
      
     
     entrocutplane = [myplane(entro_world(3,:),Hippo_headend_worldpoint(2),Hippo_headend_worldpoint(3));entro_world(3,:)];
     
     for plane = 1:FUSINUMCUTS-1
           clear temp;
        temp = [myplane(fusi_world(3,:),fusicuts(2,plane),fusicuts(3,plane));fusi_world(3,:)];
        fusi_cutplane(plane,1:2,1:length(temp))= temp;
     end

    %% ================= START CUTTING  =============================

    %cut hippo here 
    [~,hippobody] = find( hippo_world(2,:) <= hippo_headbody_cutplane(1,:));
    [~,hippohead] = find( hippo_world(2,:) > hippo_headbody_cutplane(1,:));
    
    hippobody_world = hippo_world(:,hippobody);
    hippohead_world = hippo_world(:,hippohead);
    
    %% this planes myst be defined here
    hippohead_cutplane = [myplane(hippohead_world(3,:),hippoheadmidpoint(2),hippoheadmidpoint(3));hippohead_world(3,:)];

      % Hippobody CUts
      for plane = 1:Hippobody_NUMCUTS+1
           clear temp;
           temp = [myplane(hippobody_world(3,:),hippobodycuts(2,plane),hippobodycuts(3,plane));hippobody_world(3,:)];
           hippobody_cutplane(plane,:,1:length(temp))= temp;
      end
       
        [~,hippohead1] = find( hippohead_world(2,:) <= hippohead_cutplane(1,:));
        [~,hippohead2] = find( hippohead_world(2,:) > hippohead_cutplane(1,:));
        hippohead1_world = hippohead_world(:,hippohead1);
        hippohead2_world = hippohead_world(:,hippohead2);    
    %%   =============================================
    
    %cut hippobody/para
   hippobodycut_world = nan(Hippobody_NUMCUTS+1,3,10000);
   para_worldcut = nan(Hippobody_NUMCUTS+1,3,10000);

    for segment = 1:Hippobody_NUMCUTS
        planel  = hippobody_cutplane(segment,1:2,:);
        planel = permute(planel,[2,3,1]);
        planer = hippobody_cutplane(segment+1,:,:);
        planer = permute(planer,[2,3,1]);
        [~,thiscuthippo] = find(hippobody_world(2,:) >= planer(1,:) & hippobody_world(2,:) < planel(1,:));
        hippobodycutsize(segment) = length(thiscuthippo);
        hippobodycut_world(segment,:,1:hippobodycutsize(segment)) = hippobody_world(:,thiscuthippo);   
        
        planel  = para_cutplane(segment,1:2,:);
        planel = permute(planel,[2,3,1]);
        planer = para_cutplane(segment+1,:,:);
        planer = permute(planer,[2,3,1]);
        if segment ==1
        [~,thiscutpara] = find(para_world(2,:)> planel(1,:) | (para_world(2,:)>= planer(1,:) & para_world(2,:) <= planel(1,:) ));
        else
         [~,thiscutpara] = find(para_world(2,:)>= planer(1,:) & para_world(2,:) <= planel(1,:));
        end
        paracutsize(segment) = length(thiscutpara);
        para_worldcut(segment,:,1:paracutsize(segment)) = para_world(:,thiscutpara); 
    end    
    
    % cutentro
     [~,cut1] = find( entro_world(2,:) <= entrocutplane(1,:));
     [~,cut2] = find( entro_world(2,:) > entrocutplane(1,:));
     entrosizer(1) = length(cut1);
     entrosizer(2) = length(cut2);
     entro1_world = entro_world(:,cut1);
     entro2_world = entro_world(:,cut2);
     
     % cut fusi
     for segment = 1:FUSINUMCUTS
        if segment == 1
             planer = fusi_cutplane(segment,1:2,:);
             planer = permute(planer,[2,3,1]);
           [~,thiscutfusi] = find(fusi_world(2,:) < planer(1,:));
        elseif segment ==FUSINUMCUTS 
             planer = fusi_cutplane(segment-1,1:2,:);
             planer = permute(planer,[2,3,1]);
             [~,thiscutfusi] = find(fusi_world(2,:) >= planer(1,:) );
        else
             planel  = fusi_cutplane(segment-1,1:2,:);
             planel = permute(planel,[2,3,1]);
             planer = fusi_cutplane(segment,1:2,:);
             planer = permute(planer,[2,3,1]);
             [~,thiscutfusi] = find(fusi_world(2,:) >= planel(1,:) & fusi_world(2,:) < planer(1,:));
        end
        fusicutsize(segment) = length(thiscutfusi);
        fusicut_world(segment,:,1:fusicutsize(segment)) = fusi_world(:,thiscutfusi);      
    end    

    
    %% =========     Write to files             ================= 

    hippobody_world(4,:) = ones(length(hippobody_world),1);
    hippohead_world(4,:) = ones(length(hippohead_world),1);
    hippobody_voxel =  round(affineinverse*hippobody_world);
    hippohead_voxel = round(affineinverse*hippohead_world); 
    emptybrain = zeros(braindims);
    for i=1:length(hippobody_voxel)
        emptybrain(hippobody_voxel(1,i),hippobody_voxel(2,i),hippobody_voxel(3,i)) = 1;
    end
    fname = strcat(sprintf('%02d',subject),'_',nameprefix,'hippobody');
    hippoheader.fname = strcat(outdir,'/',fname);
    rest_WriteNiftiImage(emptybrain,hippoheader,fname);
    
    emptybrain = zeros(braindims);
    for i=1:length(hippohead_voxel)
        emptybrain(hippohead_voxel(1,i),hippohead_voxel(2,i),hippohead_voxel(3,i)) = 1;
    end
    fname = strcat(sprintf('%02d',subject),'_',nameprefix,'hippohead');
    hippoheader.fname = strcat(outdir,'/',fname);
    rest_WriteNiftiImage(emptybrain,hippoheader,fname);

    hippohead1_world(4,:) = ones(length(hippohead1_world),1);
    hippohead2_world(4,:) = ones(length(hippohead2_world),1);
    hippohead1_voxel =  round(affineinverse*hippohead1_world);
    hippohead2_voxel = round(affineinverse*hippohead2_world); 
    
    emptybrain = zeros(braindims);
    for i=1:length(hippohead1_voxel)
            emptybrain(hippohead1_voxel(1,i),hippohead1_voxel(2,i),hippohead1_voxel(3,i)) = 1;
    end
    fname = strcat(sprintf('%02d',subject),'_',nameprefix,'hippohead_02');
    hippoheader.fname = strcat(outdir,'/',fname);
    rest_WriteNiftiImage(emptybrain,hippoheader,fname);
    
    emptybrain = zeros(braindims);
    for i=1:length(hippohead2_voxel)
         emptybrain(hippohead2_voxel(1,i),hippohead2_voxel(2,i),hippohead2_voxel(3,i)) = 1;
    end
    fname = strcat(sprintf('%02d',subject),'_',nameprefix,'hippohead_01');
    hippoheader.fname = strcat(outdir,'/',fname);
    rest_WriteNiftiImage(emptybrain,hippoheader,fname);
        
    for segment = 1:Hippobody_NUMCUTS
        emptybrain = zeros(braindims);
        thiscut = hippobodycut_world(segment,:,1:hippobodycutsize(segment));
        thiscut = permute(thiscut,[2,3,1]);
        thiscut(4,:) = ones(length(thiscut),1);
        hippobodycut_voxel =  round(affineinverse*thiscut);
        for i=1:length(hippobodycut_voxel)
            emptybrain(hippobodycut_voxel(1,i),hippobodycut_voxel(2,i),hippobodycut_voxel(3,i)) = 1;
        end
        
        fname = strcat(sprintf('%02d',subject),'_',nameprefix,'hippobody_', sprintf('%02d',segment));
        hippoheader.fname = strcat(outdir,'/',fname);
        rest_WriteNiftiImage(emptybrain,hippoheader,fname);        
    end
    
    for segment = 1:Hippobody_NUMCUTS %note paranumcuts = Hippobody_NUMCUTS
        emptybrain = zeros(braindims);
        paracut_world = para_worldcut(segment,:,1:paracutsize(segment));
        paracut_world = permute(paracut_world,[2,3,1]);
        paracut_world(4,:) = ones(length(paracut_world),1);
        paracut_voxel =  round(affineinverse*paracut_world);
        for i=1:length(paracut_voxel)
            emptybrain(paracut_voxel(1,i),paracut_voxel(2,i),paracut_voxel(3,i)) = 1;
        end
        fname = strcat(sprintf('%02d',subject),'_',nameprefix,'para_', sprintf('%02d',segment));
        paraheader.fname = strcat(outdir,'/',fname);
        rest_WriteNiftiImage(emptybrain,paraheader,fname);            
    end

    
   

     entro1_world(4,:) = ones(length(entro1_world),1);
     entro2_world(4,:) = ones(length(entro2_world),1);
     entro1_voxel =  round(affineinverse*entro1_world);
     entro2_voxel = round(affineinverse*entro2_world);
     emptybrain = zeros(braindims);
     for i=1:length(entro1_voxel)
        emptybrain(entro1_voxel(1,i),entro1_voxel(2,i),entro1_voxel(3,i)) = 1;
     end
     fname = strcat(sprintf('%02d',subject),'_',nameprefix,'entro_','02');
     entroheader.fname = strcat(outdir,'/',fname);
     rest_WriteNiftiImage(emptybrain,paraheader,fname); 
        
        emptybrain = zeros(braindims);
     for i=1:length(entro2_voxel)
        emptybrain(entro2_voxel(1,i),entro2_voxel(2,i),entro2_voxel(3,i)) = 1;
     end
     fname = strcat(sprintf('%02d',subject),'_',nameprefix,'entro_','01');
     entroheader.fname = strcat(outdir,'/',fname);
     rest_WriteNiftiImage(emptybrain,paraheader,fname); 
       
    for segment = 1:FUSINUMCUTS
        emptybrain = zeros(braindims);
        thiscut = fusicut_world(segment,:,1:fusicutsize(segment));
        thiscut = permute(thiscut,[2,3,1]);
        thiscut(4,:) = ones(length(thiscut),1);
        thiscut_voxel =  round(affineinverse*thiscut);
        for i=1:length(thiscut_voxel)
            emptybrain(thiscut_voxel(1,i),thiscut_voxel(2,i),thiscut_voxel(3,i)) = 1;
        end
        fname = strcat(sprintf('%02d',subject),'_',nameprefix,'fusi_', sprintf('%02d',FUSINUMCUTS+1-segment));
        fusiheader.fname = strcat(outdir,'/',fname);
        rest_WriteNiftiImage(emptybrain,fusiheader,fname); 
        
    end
    end
end


