for i = 1:500
a=zeros(100,1)
id=randsample(100,80)
a(id)=1;
item1(:,i)=a;
end

for i = 1:500
a=zeros(100,1)
id=randsample(100,80)
a(id)=1;
item2(:,i)=a;
end

for i = 1:500
    for j=1:100
    aa(:,j)=item1(j,i)*item2(:,i);
    end
    pair1(:,i)=reshape(aa,[],1);    
end


nois1=ones(100,500);
id1=randsample(100*500,100*500*.4);
nois1(id1)=0;
nois2=ones(10000,500);
id2=randsample(10000*500,100*50000*.4);
nois2(id2)=0;

item11=item1.*nois1;
item22=item2.*nois1;
for i = 1:500
    for j=1:100
    aa(:,j)=item11(j,i)*item22(:,i);
    end
    pair2(:,i)=reshape(aa,[],1);    
end
pair11=pair2 .*nois2;

trace(corr(pair1,pair11));
trace(corr(item1,item11));
trace(corr(item2,item22));

