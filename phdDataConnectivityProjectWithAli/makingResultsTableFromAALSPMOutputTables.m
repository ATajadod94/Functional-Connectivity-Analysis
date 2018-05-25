function outputfile = makingResultsTableFromAALSPMOutputTables(xSPM,fileName)
% first, using spm get whole brain result table, the data will be saved into the
% workspace as TabDat automatically; xSPM also autmatically appear in
% workspace.
% second, define fileName using strings, then execute the function:
%[tableFinal, tableSim]= makingResultsTableFromAALSPMOutputTables(xSPM,TabDat,fileName)
%
%ZhongxuLiu@gmail.com


% %minumum cluster shown
mimCluster = xSPM.k;
%
% % get the local maximum labeling
% aalLocals = ans;
%
% %get cluster maximum labeling
% aalCluster=ans;
% [SPM,xSPM] = spm_getSPM;
spm('defaults','fmri');
TabDat = spm_list('List',xSPM);

aalCluster =gin_clusters_plabels_zx('List',xSPM);

aalLocals = gin_list_dlabels_zx('List',xSPM);

[Label,tabLocal]  = gin_Localclusters_plabels_zx('List',xSPM);


if isempty(aalCluster.dat) | isempty(aalLocals.dat) | isempty(TabDat.dat)
    
    disp('no voxel survived the threshold');
    outputfile='no voxel survived the threshold';
    
else
    
    ncol=size(aalCluster.dat,2);
    
    % delete lines of "OUTSIDE", i.e., regions that are not belong to any
    % anatomical regions
    rowDel=false(size(aalCluster.dat,1),1);
    for i = 1:size(aalCluster.dat,1)
        % set column 5 to be the cluster size for each region
        aalCluster.dat{i,5}=floor(aalCluster.dat{i,3}.*aalCluster.dat{i,4}/100);
        
        %get all coordinates for each cluster
        xyzs(i,:) = aalCluster.dat{i,1};
        
        %find the to-be deleted "OUTSIDE" line
        if strcmp(aalCluster.dat{i,2},'OUTSIDE')
            rowDel(i,1)=true;
        end
        
        %transfer statistical from spm  table to clusters
        for j= 1: size(TabDat.dat,1)
            
            %spm coordiantes
            xyzp(j,:) = TabDat.dat{j,end};
            if issame(xyzs(i,:),xyzp(j,:))==2  %when the coordiantes are the same
                %transfer the stats
                aalCluster.dat{i,ncol+1} = TabDat.dat{j,end-3};
                aalCluster.dat{i,ncol+2} = TabDat.dat{j,end-2};
                aalCluster.dat{i,ncol+3} = TabDat.dat{j,end-1};
                aalCluster.dat{i,ncol+4} = TabDat.dat{j,end};
            end
        end
    end
    %delete OUTSIDE
    aalCluster.dat(find(rowDel==true),:)=[];
    xyzs(find(rowDel==true),:) = [];
    %find clusters aa
    [a b c]=unique(xyzs,'rows');
    [aa bb cc]=unique(c);
    for m=1:length(aa)
        %find cluster groups,i.e., regions/line belong to the same cluster
        block{m}=find(cc==aa(m));
        
        aa(m,1) = block{m}(1); % the first region in each cluster/block
        aa(m,2)=m; % sequential number of the block
        aa(m,3) = length(block{m});% subregions/lines for each cluster/block
    end
    
    clear a b c bb cc block;
    
    %sort the cluster to be the original order
    [ia ib]=sort(aa,1);
    aa(:,1)=ia(:,1);
    aa(:,2)=aa(ib(:,1),2);
    aa(:,3)=aa(ib(:,1),3);
    
    
    for n = 1:size(aa,1)
        %make a semi-table containing cluster info
        tableSemiFinal(aa(n,1)+n-1,:)= aalCluster.dat(aa(n,1),:);
        tableSemiFinal(aa(n,1)+n-1, 1)={n}; %giving cluster number
        tableSemiFinal{aa(n,1)+n-1, 3}=[];
        tableSemiFinal{aa(n,1)+n-1, 5}=[];
        tableSemiFinal{aa(n,1)+n-1, 6}=[];
        
        % adding region cluster
        tableSemiFinal(aa(n,1)+n:aa(n,1)+n+aa(n,3)-1,[2 5])=...
            aalCluster.dat(aa(n,1):aa(n,1)+aa(n,3)-1,[2 5]);
        
    end
    
    
    %add local maximum coordinates
    for kkk = 1:max(cell2mat(tableSemiFinal(:,1))) %for each cluster/block
        
        %define index for adjacent clusters cluster data
        i1=[];
        j1=[];
        for i = 1:size(tableSemiFinal,1)
            
            %find clusters i and i+1 at i1 and j1 line
            if tableSemiFinal{i,1} ==kkk
                i1=i;
                xyz1 = tableSemiFinal{i1,end};
                for j = 1:size(tableSemiFinal,1)
                    if tableSemiFinal{j,1} == kkk+1
                        xyz2 = tableSemiFinal{j, end};
                        j1=j;
                        break;
                        
                    else
                        xyz2=0;% only one cluster
                    end
                    
                end
                
                %define indx for adjacent clusters in local data
                k1=[];
                k2=[];
                ii=1;
                jj=1;
                for k = 1:size(aalLocals.dat,1)
                    %get all local coordinats from the local data
                    xyzLocal(k,:) = aalLocals.dat{k,1};
                    if issame(xyzLocal(k,:),xyz1') %find same cluster in cluster and local data for clust i
                        k1(ii) = k;
                        ii=ii+1;
                    end
                    if issame(xyzLocal(k,:),xyz2')%find same cluster in cluster and local data for clust i +1
                        k2(jj) = k;
                        jj=jj+1;
                        
                    end
                    
                end
                
                %replace the cluster name with the local max name (this is more
                %precise) the name in the cluster is the largest cluster, but
                %it should be the name with the max t value.
                tableSemiFinal{i1,2} = aalLocals.dat{min(k1),2};
                
                %if there are locals between clusters (if not , no locals
                %exist)
                if (min(k2) - max(k1))>1
                    
                    for mmm= i1+1:j1-1 %subregions in cluster data
                        for nnn=max(k1)+1:3:min(k2)-1 %subline in local data
                            if strcmp(tableSemiFinal{mmm,2},aalLocals.dat{nnn,2})%if the anatomical name match
                                tableSemiFinal(mmm,end)=aalLocals.dat(nnn,1); %copy coordinate to cluster data
                            end
                        end
                    end
                    
                elseif exist('k2')==0
                    
                    for mmm= i1+1:j1-1 %subregions in cluster data
                        for nnn=max(k1)+1:3:size(aalLocals.dat,1) %subline in local data
                            if strcmp(tableSemiFinal{mmm,2},aalLocals.dat{nnn,2})%if the anatomical name match
                                tableSemiFinal(mmm,end)=aalLocals.dat(nnn,1); %copy coordinate to cluster data
                            end
                        end
                    end
                    
                end
                
            end
            
        end
        
    end
    
    
    
    %transfer the stats from spm to the locals in the cluster table
    for i = 1:size(tableSemiFinal,1)
        for j = 1:size(TabDat.dat,1)
            if issame(tableSemiFinal{i,10},TabDat.dat{j,end}) %if the coordinates are the same
                
                tableSemiFinal{i,7} = TabDat.dat{j,end-3}; %t value
                tableSemiFinal{i,8} = TabDat.dat{j,end-2}; %z value
                tableSemiFinal{i,9} = TabDat.dat{j,end-1}; % p value
                
            end
        end
    end
    
    %delete unused column in cluster data/table
    tableSemiFinal(:,[3 6])=[];
    % delete small regions with cluster size < mimCluster
    for i = 1:size(tableSemiFinal,1)-1
        if tableSemiFinal{i,4} >= 0 & tableSemiFinal{i,4} < mimCluster
            rowDel2(i,1)=1;  % delete cluster size < mimCluster define at the begining
            if   ~isempty(tableSemiFinal{i-1,1}) & ~isempty(tableSemiFinal{i+1,1})
                rowDel2(i,1)=0; % if only one region in a cluster, not delete even < minimumCluster
                
            end
            
        else
            rowDel2(i,1)=0;%no need to delete
        end
    end
    tableSemiFinal(find(rowDel2==true),:)=[];
    
    %set up a new table for final use with title
    [m n]=size(tableSemiFinal);
    tableFinal(2:1+m,2:1+n)=tableSemiFinal;
    tableFinal(:,1) = tableFinal(:,2);
    
    %move cluster to column2
    for i = 1:size(tableFinal,1)
        if tableFinal{i,1}>0
            tableFinal{i,2}=tableFinal{i,3};
            tableFinal{i,3}=[];
        end
    end
    
    % delete the line if the subregion is the same as the cluster
    rowDel =zeros(size(tableFinal,1),1);
    for i = 1:size(tableFinal,1)-1
        if tableFinal{i,1}>0 & isempty(tableFinal{i+1,1})& tableFinal{i,4}==tableFinal{i+1,5}
            rowDel(i+1,1) = 1;
            
        end
    end
    tableFinal(rowDel==1,:)=[];
    
    for i = 1:size(tableFinal,1)
        if ~isempty(tableFinal{i,9})
            
            tableFinal{i,10} = tableFinal{i,9}(1);
            tableFinal{i,11} = tableFinal{i,9}(2);
            tableFinal{i,12} = tableFinal{i,9}(3);
        end
    end
    tableFinal(:,9)=[];
    
    % set tittle
    tableFinal(1,2) = {'Clusters'};
    tableFinal(1,3) = {'Subregions'};
    tableFinal(1,4) = {'Cluster Size'};
    tableFinal(1,5) = {'Subregion Size'};
    tableFinal(1,6) = {'t value'};
    tableFinal(1,7) = {'z value'};
    tableFinal(1,8) = {'p value'};
    tableFinal(1,10) = {'MNI Coordinates'};
    
    %simplified version: only keep the line with statistics
    tableSim = tableFinal;
    rowDel=[];
    for i = 1:size(tableSim,1)
        if isempty(tableSim{i,10})
            rowDel(i) = 1;
        else
            rowDel(i) = 0;
        end
    end
    tableSim(find(rowDel==1),:)=[];
    
%     if length([pwd,fileName,'-simple.xls']) >200
%     xlswrite([xSPM.sswd,fileName,'-simple.xls'], tableSim);
%     xlswrite([xSPM.sswd,fileName,'-complex.xls'], tableFinal);
%     else
%     
    xlswrite([fileName,'-simple.xls'], tableSim);
    xlswrite([fileName,'-complex.xls'], tableFinal);
%     end
    
    
    % *********************************************a better table*******
    
    nblock = 0;
    for i = 1: size(tabLocal,2)
        
        idLine = zeros(size(tabLocal,1),1);
        for j = 1:size(tabLocal,1)
            if size(tabLocal{j,i},2)>1
                idLine(j)=1;
            end
        end
        
        
        if max(idLine)~=0
            %get label from Lable for each block
            lableLine = {Label(i).label(1,find(idLine==1)).Nom};
            
            %update unempty block number
            nblock = nblock + 1;
            
            % add subcluster size
            kk=find(idLine ==1);
            for k = 1:length(kk)
                tabLocal{kk(k),i}{1,5} = sum(cell2mat(tabLocal{kk(k),i}(1:end,5)));
                tabLocal{kk(k),i}(2:end,5) = {0};
            end
            
            
            %combine all line in that block
            blockLine{nblock} = cat(1,tabLocal{find(idLine==1),i});
            blockLine{nblock} = cat(1,blockLine{nblock},cell(1,size(blockLine{nblock},2)));% add a empty line beween clusters
            
            %add lable to the first line of each subbcluster
            idAddLable = zeros(size(blockLine{nblock},1),1);
            for k = 1:size(blockLine{nblock},1)
                %find the first line for each subcluster
                if abs((blockLine{nblock}{k,1}-1))<.001 %zx: easy to have a bug should set first line to integer 1 then this condition set to 0
                    idAddLable(k) = 1;
                end
            end
            
            mm = find(idAddLable==1);
            %the number of the firstline should be the same of the size of the
            %labels
            if length(mm)==size(lableLine,2)
                for m = 1:length(mm)
                    blockLine{nblock}{mm(m),1}=lableLine{m};
                end
            else
                disp('check Lable and tabLocal, idx not match')
                return;
            end

        end
        
    end
    
    if  exist('blockLine')
        tmpLine =cat(1,blockLine{:});
        allLines=cell(size(tmpLine,1)+1,size(tmpLine,2)+3);
        allLines(2:end,1:size(tmpLine,2))=tmpLine; %a add one more line to be header
        for ii = 2:size(allLines,1)
            if ~isempty(allLines{ii,end-3});
                
                allLines{ii,end-2}= allLines{ii,end-3}(1);
                allLines{ii,end-1}= allLines{ii,end-3}(2);
                allLines{ii,end-0}= allLines{ii,end-3}(3);
            end
            
        end
        
        
        idStr = zeros(size(allLines,1),1);
        for ii = 1:size(allLines,1)
            if ~isempty(allLines{ii,1})
                idStr(ii)=1;
            end
        end
        idTrans = find(idStr==1);
        allStr=allLines(find(idStr==1),1);
        [aa bb]=sort(allStr);
        
        allStr = allStr(bb);
        idTrans1=idTrans(bb);
        
        idtmp=cumsum(idStr);
        
        %also find the transfered idx for subcluster
        idTrans2 = [];
        for i=1:length(idTrans1)
            a = 0;
            id1 = [];
            for j = idTrans1(i): length(idtmp)-1
                if idtmp(j)==idtmp(idTrans1(i))
                    a = a +1;
                    id1(a,1)=j;
                end
            end
            idTrans2=cat(1,idTrans2, id1(:,1));
        end
        
        sortedForm = allLines(idTrans2,:);
        
        idemp1 = zeros(size(sortedForm,1),1);
        idemp2 = zeros(size(sortedForm,1),1);
        for i = 1:size(sortedForm,1)
            if ~isempty(sortedForm{i,12})
                idemp1(i) = 1;
            end
            
            if ~isempty(sortedForm{i,1})
                idemp2(i) = 1;
            end
        end
        sortedForm1 = sortedForm(find(idemp1==1),:);
        sortedForm2 = sortedForm(find(idemp2==1),:);
        aa=sortedForm2(:,1);
        [a b c]=unique(aa,'stable');
        sortedForm2(:,2)={''};
        sortedForm2(b,2)=sortedForm2(b,1);
        
        allLines(:,[2:4,6:8,12])=[];
        sortedForm1(:,[2:4,6:8,12])=[];
        sortedForm2(:,[1,3:4,6:8,12])=[];
        
        clusterForm=allLines;
        iddel = zeros(size(clusterForm,1),1);
        for i = 1:length(iddel)
            if clusterForm{i,2}==0
                iddel(i)=1;
            end
        end
        clusterForm(find(iddel==1),:)=[];
        clusterFormFinal = cell(size(clusterForm,1)+1,size(clusterForm,2)+1);
        clusterFormFinal(2:end,2:end) = clusterForm;
        
        iddel = zeros(size(clusterFormFinal,1),1);
        k=1;
        for i = 3:size(clusterFormFinal,1)
            if ~isempty(clusterFormFinal{i,2}) && isempty(clusterFormFinal{i-1,2})
                clusterFormFinal{i,1}= k;
                k=k+1;
            end
            
            if isempty(clusterFormFinal{i,2})
                iddel(i) = 1;
            end
        end
        
        clusterFormFinal(find(iddel==1),:)=[];
        clusterFormFinal{1,1}='Cluster';
        clusterFormFinal{1,2}='Region';
        clusterFormFinal{1,3}='Size';
        clusterFormFinal{1,4}='t';
        clusterFormFinal{1,5}='z';
        clusterFormFinal{1,6}='p';
        clusterFormFinal{1,8}='MNI';
        clusterFormFinal{2,7}='x';
        clusterFormFinal{2,8}='y';
        clusterFormFinal{2,9}='z';
        
%         if length([pwd,fileName,'-clusterform.xls']) >200
%             xlswrite([xSPM.sswd,fileName,'-sorted2.xls'], sortedForm2);
%             xlswrite([xSPM.sswd,fileName,'-clusterform.xls'], clusterFormFinal);
%         else
            xlswrite([fileName,'-sorted2.xls'], sortedForm2);
            xlswrite([fileName,'-clusterform.xls'], clusterFormFinal);
%         end
        %***************************************************************
        
        
        outputfile.tableFinal = tableFinal;
        outputfile.tableSim = tableSim;
        outputfile.sortedForm = sortedForm;
        outputfile.sortedForm1 = sortedForm1;
        outputfile.sortedForm2 = sortedForm2;
        outputfile.clusterForm = clusterFormFinal;
        outputfile.allLines = allLines ;
        save([fileName,'dataForMakingResultForms'],'outputfile');
    else
        
        outputfile.tableFinal = tableFinal;
        outputfile.tableSim = tableSim;
        sortedForm2='no voxel survived';
        clusterFormFinal = 'no voxel survived';
        
        
                        
%         if length([pwd,fileName,'dataForMakingResultForms']) >200
%             xlswrite([xSPM.sswd,fileName,'-sorted2.xls'], sortedForm2);
%             xlswrite([xSPM.sswd,fileName,'-clusterform.xls'], clusterFormFinal);
%             save([fileName,'dataForMakingResultForms'],'outputfile');
%         else
            xlswrite([fileName,'-sorted2.xls'], sortedForm2);
            xlswrite([fileName,'-clusterform.xls'], clusterFormFinal);
            save([fileName,'dataForMakingResultForms'],'outputfile');
%         end
    end
end