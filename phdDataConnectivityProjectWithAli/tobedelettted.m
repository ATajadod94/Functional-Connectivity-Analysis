

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
            if abs((blockLine{nblock}{k,1}-1))<.000001
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
