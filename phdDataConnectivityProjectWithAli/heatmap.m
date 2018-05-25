im1=zeros(600,600);
im1(randsample(600*600,20))=1:20;
figure; imshow(im1);
[a b ]=find(im1~=0)
c=[a b];
for i  = 1: length(a)
    
    d{i}= repmat(c(i,:),im1(c(i,1),c(i,2)),1);
end

fixations = cat(1,d);
heatmap(d)
figure;imshow(im1);

im2=imgaussfit(im1,12.5);
figure;imshow(im2);