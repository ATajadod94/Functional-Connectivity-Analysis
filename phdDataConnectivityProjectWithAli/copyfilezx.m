path = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\participant01\scanImgData\baselineRest\';
f = dir([path '*.img']);
for i = 1:length(f)
    copyfile([path, f(i).name],[path,'a',sprintf('%04d',i),'.img']);    
end

f = dir([path '*.hdr']);
for i = 1:length(f)
    copyfile([path, f(i).name],[path,'a',sprintf('%04d',i),'.hdr']);    
end