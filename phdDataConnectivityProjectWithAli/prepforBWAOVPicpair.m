function xh=prepforBWAOVPicpair(x1)
  xh(:,1)=reshape(x1',1,size(x1,2)*size(x1,1))';
  xh(:,2)=1;
  conindex=ones(size(x1,1),size(x1,2));
  for i=2:size(x1,2)
  conindex(:,i)=i*conindex(:,i);
  end
  pindex(:,1)=1:size(x1,1);
  for i=2:size(x1,2)
      pindex(:,i)=pindex(:,1);
  end
  xh(:,3)=reshape(conindex',1,size(x1,2)*size(x1,1))';
  xh(:,4)=reshape(pindex',1,size(x1,2)*size(x1,1))';
end
  
