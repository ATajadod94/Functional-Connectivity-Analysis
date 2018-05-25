m=0;
for k = .02:.02:.2
    m=m+1;
    beta1 = 0 + 1./sqrt(180)*randn(1000,1);
    for i = 1:1000
        x=randn(180,1);
        %  beta(i,1)=randsample(-1:.001:1,1);
        x1=x*tanh(beta1(i,1))+randn(180,1);
        
        aa1=corr(x,x1);
        bb1(i,1) = .5*log((1.+aa1)/(1-aa1));
        cc(i,1)=std(x);
    end
    
    
    
    beta2 = k + 1./sqrt(180)*randn(1000,1);
    for i = 1:1000
        x=randn(180,1);
        %  beta(i,1)=randsample(-1:.001:1,1);
        x1=x*tanh(beta2(i,1))+randn(180,1);
        
        aa=corr(x,x1);
        bb2(i,1) = .5*log((1.+aa)/(1-aa));
        cc(i,1)=std(x);
    end
    
    
    for n = 5:50
        for j = 1:1000
            disp(k)
            disp(n)
            disp(j)
            ids=randsample(1:1000,n);
            y1 =bb1(ids);
            y2=bb2(ids);
            h05(j,n,m)=ttest(y1,y2,.05);
            h005(j,n,m)=ttest(y1,y2,.005);
        end
    end
end
fr05=h05(1:1000,:,:);
fr005=h005(1:1000,:,:);
figure;
for mm=1:10
plot(sum(fr05(:,:,mm),1)/1000,'b');
hold on;
plot(sum(fr005(:,:,mm),1)/1000,'r');
hold on;
end
xlim([5 50]);


hold on; plot(sum(h005,1)/1000,'r');

y2std=std(bb)

y1std=mean(cc)