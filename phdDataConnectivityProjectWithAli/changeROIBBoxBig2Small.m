    
for isubj = 2:20
rootDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d', isubj),'\'];
    maskDir1       = [rootDir,'encoding\analysis\'];
   f= dir([maskDir1,'*indivRoi.img']);
   for k=1:length(f)
        convertROIMasks([maskDir1,f(k).name],[maskDir1,f(k).name(1:13),'-smBBox.img'],[maskDir1,'encoding05ROIBox799568.img']);
   end
end