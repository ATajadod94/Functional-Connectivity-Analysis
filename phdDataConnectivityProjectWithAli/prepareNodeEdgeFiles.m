function prepareNodeEdgeFiles(fileL, fileR, outFileName)
% outFileName = 'RL-HPC-PPI-nonfam';
% if ~iscell(seedData)
%     if strcmp(seedData,'HPC');
%        clear seedData;
      seedData(1,:)={-25.03,-20.74,	-10.13, 1, 100,'L-HPC'};   
      seedData(2,:)={29.23,	-19.78,	-10.33, 1, 100,'R-HPC'};
%     end
% 
% end

%load left hpc connectivity ppi data
load(fileL);
targetDataL=outputfile.sortedForm2;
targetDataL(:,end+1) = {4};
targetDataL(:,end+1) = targetDataL(:,2);
targetDataL(:,end+1) = targetDataL(:,1);
edgeDataL = cell2mat(targetDataL(:,3));


%load right hpc connectivity ppi data
load(fileR);
targetDataR=outputfile.sortedForm2;
targetDataR(:,end+1) = {4};
targetDataR(:,end+1) = targetDataR(:,2);
targetDataR(:,end+1) = targetDataR(:,1);
edgeDataR = cell2mat(targetDataR(:,3));



targetDataL(:,1:5)=[];
targetDataR(:,1:5)=[];

nodeData=cat(1,seedData,targetDataL,targetDataR);
% meand node size to hpc
nodeData(1:2,5) = {2*max(cell2mat(nodeData(:,5)))};
for i = 1:size(nodeData,1)
   if isempty(nodeData{i,end})
       nodeData{i,end}=nodeData{i-1,end};
   end
       
end

edgeData=zeros(size(nodeData,1),size(nodeData,1));
edgeDataLR = blkdiag(edgeDataL,edgeDataR);
edgeData(3:end,1:2) = edgeDataLR;
edgeData = edgeData + edgeData';
%   xlswrite([outFileName,'.nodes.txt'], nodeData);
%   xlswrite([outFileName,'.adege.txt'], edgeData);
save([outFileName,'.edge.txt'],'-ascii', 'edgeData');

  
% nodeData is a cell array, txt write doesn't work, so using fprintf 
x=nodeData;
fid = fopen([outFileName,'.node.txt'],'w');
% fid=fopen(sprintf('%s',outfile),'w');
 if(fid)
       for i=1:size(x,1)
         fprintf(fid,'%d\t\t%d\t\t%d\t%d\t%d\t\t%s\n',x{i,1},x{i,2},x{i,3},x{i,4},x{i,5},x{i,6});
     end
     fclose(fid);
 end