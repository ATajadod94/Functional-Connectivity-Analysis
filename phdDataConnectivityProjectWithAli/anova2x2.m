function stats = anova2x2(x1,x2,fac1,fac2,outpath,fsize,lsize,figureName)

a=prepforBWAOVPicpair(x1);

b=prepforBWAOVPicpair(x2);

b(:,2)=2;
x=[a;b];
%***** ANOVA output 3 p value 1, between factor, 2, within factor, 3,
%interaction
% fac1={'Intact','Recombined'};
% fac2={'famous','nonfamous'};
FACTNAMES={fac1,fac2};
stats=rm_anova2(x(:,1),x(:,4),x(:,2),x(:,3),FACTNAMES);

groupnames=char(['  famous '; 'nonfamous']);
bw_legend=['  remem  ';'forgotten'];
bw_ylabel = [' beta estimates'];
picpair2x2Anovafig(x1', x2',groupnames,bw_legend,bw_ylabel,figureName,outpath,fsize,lsize);
end