
y=rand(100,60);
x=rand(100,60);

ptx=corr(x');
pty=corr(y');


x1=reshape(ptx,size(ptx,1)*size(ptx,2),1);
x1(x1==1)=[];

y1=reshape(pty,size(pty,1)*size(pty,2),1);
y1(y1==1)=[];

ptsim1 = corr(reshape(ptx,size(ptx,1)*size(ptx,2),1),...
reshape(pty,size(pty,1)*size(pty,2),1))

ptsim11 = corr(x1, y1)

x(1:100,:)=repmat(x(:,1),1,60).*(.1*abs(rand(100,60)));

x(:,1:2:end)=y(:,1:2:end)+.2*rand(100,30);
% y(2:2:end,:)=1*x(2:2:end,:)+.2*rand(50,60);

ptx=corr(x');
pty=corr(y');


x1=reshape(ptx,size(ptx,1)*size(ptx,2),1);
x1(x1==1)=[];

y1=reshape(pty,size(pty,1)*size(pty,2),1);
y1(y1==1)=[];

ptsim1 = corr(reshape(ptx,size(ptx,1)*size(ptx,2),1),...
reshape(pty,size(pty,1)*size(pty,2),1))

ptsim11 = corr(x1, y1)



x(1:4:end,:)=y(2:4:end,:)+rand(25,60);
y(1:4:end,:)=x(2:4:end,:)+rand(25,60);

ptx=corr(x');
pty=corr(y');


x1=reshape(ptx,size(ptx,1)*size(ptx,2),1);
x1(x1==1)=[];

y1=reshape(pty,size(pty,1)*size(pty,2),1);
y1(y1==1)=[];

ptsim1 = corr(reshape(ptx,size(ptx,1)*size(ptx,2),1),...
reshape(pty,size(pty,1)*size(pty,2),1))

ptsim11 = corr(x1, y1)


for i= 1:size(x,2)
    for j = 1:size(y,2)
        
        pttmp(i,j) = corr(x(:,i),y(:,j));
    end
end

ptsim2=mean(mean(pttmp));


