for i = 1:16
    [B,BINT,R,RINT,STATS]=regress(data((i-1)*5+1:i*5,1),[[1 1 1 1 1]',[-2/3,-1/3,0,1/3,2/3]']);
    resest(i)=STATS(4)
end

sum(resest)

for i = 1:16
    [B,BINT,R,RINT,STATS]=regress(data((i-1)*5+1:i*5,1),[[1 1 1 1 1]',[-1,1/4,1/4,1/4,1/4]']);
    resest(i)=STATS(4);
end
sum(resest)