for n = 1:10
    fpuls = dir([num2str(n),'*.puls.1D']);
a(n) = length(fpuls);
end
for n= 1:length(fpuls)
if str2num(fpuls(n).name(9))==1
  idsub(n)= str2num(fpuls(n).name(9:13));
else 
idsub(n)= str2num(fpuls(n).name(9:12));
end
end