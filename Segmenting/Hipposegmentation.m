%CUTFUSIFORM
%MAKE PARA INTO 4


clear;
addpath(genpath('/Users/Ali/Documents/MATLAB/REST_V1.8_130615'))
hippodir = '/Users/Ali/Desktop/Baycrest/Data/Post_Free_Label/01/mri/HippRois';
EntoRhinaldir = '/Users/Ali/Desktop/Baycrest/Data/Post_Free_Label/01/mri/EntoRhinalRois01';
ParaHippodir = '/Users/Ali/Desktop/Baycrest/Data/Post_Free_Label/01/mri/ParaHippocampalRois01';
Fusiformdir =   '/Users/Ali/Desktop/Baycrest/Data/Post_Free_Label/01/mri/fusiform01';

cd (hippodir)
hippofiles = dir('*.nii');
hippofiles = hippofiles(1:2);
cd (EntoRhinaldir) 
EntoRhinalfiles = dir('*.nii');
cd (ParaHippodir) 
ParaHippofiles = dir('*.nii');
cd (Fusiformdir)
Fusiformfiles = dir('*.nii');


for counter=2
    %% ================= READ IN DATA ========================%%%
    [hippodata,hippoheader] = rest_ReadNiftiImage(fullfile(hippodir,hippofiles(counter).name));
    [entrodata,entroheader] = rest_ReadNiftiImage(fullfile(EntoRhinaldir,EntoRhinalfiles(counter).name));
    [paradata,paraheader] = rest_ReadNiftiImage(fullfile(ParaHippodir,ParaHippofiles(counter).name));
    [fusidata,fusiheader] = rest_ReadNiftiImage(fullfile(Fusiformdir,Fusiformfiles(counter).name));
    
    dims = size(hippodata);
    %% add check for dimensions, must all be same
    emptybrain = zeros(dims);
    
    
    %% =================  Create CUT PLANE ========================%%%

    affinematrix = hippoheader.private.mat0(1:3,:);
    %%add consistantly check
    
    affineinverse = inv(hippoheader.private.mat0);
    affineinverse = affineinverse(1:3,:);
    
    endpoints_voxels = zeros(2,3);
    endpoints_cordinates = zeros(2,3);
    
    T1 = find(hippodata,1,'first');
    [i,j,k] = ind2sub(dims,T1(1));
    endpoints_voxels(1,:) = [i,j,k];
    T1 = find(hippodata,1,'last');
    [i,j,k] = ind2sub(dims,T1(1));
    endpoints_voxels(2,:) = [i,j,k];
    endpoints_voxels = [endpoints_voxels,[1;1]];
    
    endpoints_cordinates = affinematrix*endpoints_voxels';
    dirvector = endpoints_cordinates(:,2) - endpoints_cordinates(:,1);
    vectordistance = sqrt(sum(dirvector.^2));
    dirvector = dirvector ./vectordistance;
    cutvector = [-dirvector(3);dirvector(2)];    
    
    % myplane returns z for plane on point  p2,p3 preprendicular to 
    % Equations
    %myplane = @(y,p2,p3)    -(dirvector(1)*(y-p2) - (p3*dirvector(2)))/dirvector(2);
    %myplane = @(z,p2,p3)   -(z * dirvector(2) + p3*dirvector(2)  + dirvector(1) * p2 )/dirvector(1);
    myplane =  @(z,inity,initz)  inity+ ((z-initz)/cutvector(2))*cutvector(1);
    distance = @(A,B) abs(sqrt(sum((A-B).^2)));
    
    %% ================= GET MY INTRESTING POINTS ========================%%%
    temp = find(entrodata,2,'last');
    [i,j,k] = ind2sub(dims,temp(1));
    plane1_voxelpoint = [i,j,k,1];
    plane1_worldpoint = affinematrix*plane1_voxelpoint';
    
    temp = find(hippodata,2,'first');
    [i,j,k] = ind2sub(dims,temp(1));
    plane2_voxelpoint = [i,j,k,1];
    plane2_worldpoint = affinematrix*plane2_voxelpoint';
    
    temp = find(hippodata,2,'last');
    [i,j,k] = ind2sub(dims,temp(1));
    plane3_voxelpoint = [i,j,k,1];
    plane3_worldpoint = affinematrix*plane3_voxelpoint';
    
    
    
    %% ================= CUT HIPPO INTO 2 , hippohead and hippotail======%%
    %% The relevant plane here is plane 1

    %% Set up Hippo data
    hipp_idx = find(hippodata);
    [hippox,hippoy,hippoz] = ind2sub(dims,hipp_idx);
    hippo_voxel = [hippox,hippoy,hippoz];
    hippo_voxel = [hippo_voxel,ones(length(hippo_voxel),1)];
    hippo_world = affinematrix*hippo_voxel';
    hippoy_world = hippo_world(2,:);
    hippoz_world = hippo_world(3,:);
    hippoyz = [hippoy_world;hippoz_world];
    
    cutplane = [myplane(hippoz_world,plane1_worldpoint(2),plane1_worldpoint(3));hippoz_world];
     [~,hippobody] = find( hippoyz(1,:) <= cutplane(1,:));
     [~,hippohead] = find( hippoyz(1,:) > cutplane(1,:));
     hippobodysizy = length(hippobody);
     hippoheadsize = length(hippohead);
     hippobody_world = hippo_world(:,hippobody);
     hippohead_world = hippo_world(:,hippohead);
     
    %%plot sanity check
    figure(1)
    scatter(hippo_world(2,:),hippo_world(3,:)) 
    hold on;
    scatter(hippohead_world(2,:),hippohead_world(3,:),'r')
    scatter(hippobody_world(2,:),hippobody_world(3,:),'g')
    hold off;
    %%write this cuts to file 
    names = ['HippoBody';'HippoHead'];
    hippobody_world(4,:) = ones(length(hippobody_world),1);
    hippohead_world(4,:) = ones(length(hippohead_world),1);
    hippobody_voxel =  round(affineinverse*hippobody_world);
    hippohead_voxel = round(affineinverse*hippohead_world); 
    
    emptybrain = zeros(dims);
    for i=1:length(hippobody_voxel)
        emptybrain(hippobody_voxel(1,i),hippobody_voxel(2,i),hippobody_voxel(3,i)) = 1;
    end
    rest_WriteNiftiImage(emptybrain,hippoheader,names(1,:))
    
    emptybrain = zeros(dims);
    for i=1:length(hippohead_voxel)
        emptybrain(hippohead_voxel(1,i),hippohead_voxel(2,i),hippohead_voxel(3,i)) = 1;
    end
    rest_WriteNiftiImage(emptybrain,hippoheader,names(2,:))

    %% HIPPOBODY_HEAD CUT AND WRITTEN TO FILE %%     
    %% CUT HIPPO HEAD INTO 2 %%
    temp = find(entrodata,2,'last');
    [i,j,k] = ind2sub(dims,temp(1));
    Hippo_headstart = [i,j,k,1];
    Hippo_headstart_worldpoint = affinematrix*Hippo_headstart'; 
    
    Hippo_headend_worldpoint = endpoints_cordinates(:,1); %%calcualted for the vecotr
    hippoheadmidpoint = (Hippo_headend_worldpoint+Hippo_headstart_worldpoint)./2;
    
    
    %% ================= ==============================%%
    %% Set up Hippohead data
        hippohead_world;
        hippoheadmidpoint;
        cutplane = [myplane(hippohead_world(3,:),hippoheadmidpoint(2),hippoheadmidpoint(3));hippohead_world(3,:)];
        [~,hippohead1] = find( hippohead_world(2,:) <= cutplane(1,:));
        [~,hippohead2] = find( hippohead_world(2,:) > cutplane(1,:));
        hippobodysizy = length(hippohead1);
        hippoheadsize = length(hippohead2);
        hippohead1_world = hippohead_world(:,hippohead1);
        hippohead2_world = hippohead_world(:,hippohead2);
     
        %%plot sanity check
        figure(1)
        scatter(hippohead_world(2,:),hippohead_world(3,:)) 
        hold on;
        scatter(hippohead1_world(2,:),hippohead1_world(3,:),'r')
        scatter(hippohead2_world(2,:),hippohead2_world(3,:),'g')
         hold off;

        names = ['HippoHead1';'HippoHead2'];
        hippohead1_world(4,:) = ones(length(hippohead1_world),1);
        hippohead2_world(4,:) = ones(length(hippohead2_world),1);
        hippohead1_voxel =  round(affineinverse*hippohead1_world);
        hippohead2_voxel = round(affineinverse*hippohead2_world); 

        emptybrain = zeros(dims);
        for i=1:length(hippohead1_voxel)
            emptybrain(hippohead1_voxel(1,i),hippohead1_voxel(2,i),hippohead1_voxel(3,i)) = 1;
        end
        rest_WriteNiftiImage(emptybrain,hippoheader,names(1,:))

        emptybrain = zeros(dims);
        for i=1:length(hippohead2_voxel)
            emptybrain(hippohead2_voxel(1,i),hippohead2_voxel(2,i),hippohead2_voxel(3,i)) = 1;
        end
        rest_WriteNiftiImage(emptybrain,hippoheader,names(2,:))

        
        %%CUT HIPPOBODY ==============================================  %%
        %% CUT HIPPOBODY INTO NUMCUTS %%
        Hippo_bodystart_worldpoint = endpoints_cordinates(:,2);
        Hippo_headstart_worldpoint;
        bodydistance = distance( Hippo_bodystart_worldpoint,Hippo_headstart_worldpoint);
        hippobody_world;
        NUMCUTS = 4;
        cutdistances = linspace(0,bodydistance,5);
        cutpoints = Hippo_headstart_worldpoint + dirvector*cutdistances;
        clear cutplane;
       for segment = 1:NUMCUTS+1
           clear temp;
        temp = [myplane(hippobody_world(3,:),cutpoints(2,segment),cutpoints(3,segment));hippobody_world(3,:)];
        cutplane(segment,:,1:length(temp))= temp;
       end
       
                 %% Set up parahipp  for cut %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    para_idx = find(paradata);
    [parax,paray,paraz] = ind2sub(dims,para_idx);
    para_voxel = [parax,paray,paraz];
    para_voxel = [para_voxel,ones(length(para_voxel),1)];
    para_world = affinematrix*para_voxel';
    paray_world = para_world(2,:);
    paraz_world = para_world(3,:);
    parayz = [paray_world;paraz_world];
    paraworldcut = nan(NUMCUTS+1,3,10000);
     for segment = 1:NUMCUTS+1
        clear temp;
        temp = [myplane(paraz_world,cutpoints(2,segment),cutpoints(3,segment));paraz_world];
        paracutplane(segment,:,1:length(temp))= temp;
     end
           %%Cut Hippocampus 
hippobodycut = nan(NUMCUTS,4,10000);

    for segment = 1:NUMCUTS
        planel  = cutplane(segment,1:2,:);
        planel = permute(planel,[2,3,1]);
        planer = cutplane(segment+1,:,:);
        planer = permute(planer,[2,3,1]);
        [~,thiscuthippo] = find(hippobody_world(2,:) >= planer(1,:) & hippobody_world(2,:) < planel(1,:));
        hippocutsize(segment) = length(thiscuthippo);
        hippobodycut(segment,:,1:hippocutsize(segment)) = hippobody_world(:,thiscuthippo); 
       
    end    
    saver = [];
    for segment = 1:NUMCUTS
        planel  = paracutplane(segment,1:2,:);
        planel = permute(planel,[2,3,1]);
        planer = paracutplane(segment+1,:,:);
        planer = permute(planer,[2,3,1]);
        if segment ==1
        [~,firstcutpara] = find(paray_world> planel(1,:));
        end
         [~,thiscutpara] = find(paray_world>= planer(1,:) & paray_world <= planel(1,:));
         saver = [saver,thiscutpara];
        paracutsize(segment) = length(thiscutpara);
        paraworldcut(segment,:,1:paracutsize(segment)) = para_world(:,thiscutpara); 
       
    end    

        segment = NUMCUTS + 1;
        paracutsize(segment) = length(firstcutpara);
        paraworldcut(segment,:,1:paracutsize(segment)) = para_world(:,firstcutpara); 

 
    %WriteHippocampus to File
    names = ['hippobody1';'hippobody2';'hippobody3';'hippobody4'];
    for segment = 1:NUMCUTS
        emptybrain = zeros(dims);
        hippobodycut_world = hippobodycut(segment,:,1:hippocutsize(segment));
        hippobodycut_world = permute(hippobodycut_world,[2,3,1]);
        %hippobodycut_world(4,:) = ones(length(hippobodycut_world),1);
        hippobodycut_voxel =  round(affineinverse*hippobodycut_world);
        for i=1:length(hippobodycut_voxel)
            emptybrain(hippobodycut_voxel(1,i),hippobodycut_voxel(2,i),hippobodycut_voxel(3,i)) = 1;
        end
        
        rest_WriteNiftiImage(emptybrain,hippoheader,names(segment,:))
        
    end
    
        %Write PARA to File
    names = ['PARA1';'PARA2';'PARA3';'PARA4';'PARA5'];
    for segment = 1:NUMCUTS+1
        emptybrain = zeros(dims);
        paracut_world = paraworldcut(segment,:,1:paracutsize(segment));
        paracut_world = permute(paracut_world,[2,3,1]);
        paracut_world(4,:) = ones(length(paracut_world),1);
        paracut_voxel =  round(affineinverse*paracut_world);
        for i=1:length(paracut_voxel)
            emptybrain(paracut_voxel(1,i),paracut_voxel(2,i),paracut_voxel(3,i)) = 1;
        end
        
        rest_WriteNiftiImage(emptybrain,paraheader,names(segment,:))
        
    end

    
    
    %% Set up adnd cut Entro  ================== %%%%%%%%%%%%%%%%%%%%%%%%%
   Hippo_headend_worldpoint;
     entro_idx = find(entrodata);
    [entrox,entroy, entroz] = ind2sub(dims,entro_idx);
    entro_voxel = [entrox,entroy,entroz];
    entro_voxel = [entro_voxel,ones(length(entro_voxel),1)];
    entro_world = affinematrix*entro_voxel';
    entroy_world = entro_world(2,:);
    entroz_world = entro_world(3,:);
    entroyz = [entroy_world;entroz_world];
    entroworldcut = nan(2,3,10000);
        clear cutplane;

   cutplane = [myplane(entroz_world,Hippo_headend_worldpoint(2),Hippo_headend_worldpoint(3));entroz_world];
    scatter(cutplane(1,:),cutplane(2,:))
  
    %%Cut and write entro 
     [~,cut1] = find( entroyz(1,:) <= cutplane(1,:));
     [~,cut2] = find( entroyz(1,:) > cutplane(1,:));
     entrosizer(1) = length(cut1);
     entrosizer(2) = length(cut2);
     cut1_world = entro_world(:,cut1);
     cut2_world = entro_world(:,cut2);
     names = ['entro1';'entro2'];
     cut1_world(4,:) = ones(length(cut1_world),1);
     cut2_world(4,:) = ones(length(cut2_world),1);
     cut1_voxel =  round(affineinverse*cut1_world);
     cut2_voxel = round(affineinverse*cut2_world);
     emptybrain = zeros(dims);
     for i=1:length(cut1_voxel)
        emptybrain(cut1_voxel(1,i),cut1_voxel(2,i),cut1_voxel(3,i)) = 1;
     end
     rest_WriteNiftiImage(emptybrain,entroheader,names(1,:))
     emptybrain = zeros(dims);
     for i=1:length(cut2_voxel)
        emptybrain(cut2_voxel(1,i),cut2_voxel(2,i),cut2_voxel(3,i)) = 1;
     end
     rest_WriteNiftiImage(emptybrain,entroheader,names(2,:))

     

    











end




