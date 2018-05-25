path = [pwd,'\scanImgData\run_0005\'];
f = dir([path,'*.hdr']);
hdrFunc=spm_read_hdr([path,f(1).name]);