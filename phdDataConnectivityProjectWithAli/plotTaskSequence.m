pathf = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\picPairFigures\';

x1 = myDesignEncode1.event(:,1);
x2 = myDesignEncode1.event(:,2);



for i = 1: length(x1)
    
    a{i} = ones(x1(i),1)*x2(i);
end
aa = cat(1,0,a{:});

s=figure;plot(aa);
ylim([0,5]);
axis off;
plot2svg([pathf,'tasksequence.svg'],s);
    