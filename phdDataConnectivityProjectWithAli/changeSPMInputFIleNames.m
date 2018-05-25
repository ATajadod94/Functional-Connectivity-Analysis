
for n = 1:20
SPM.xY.P{1,n}= strrep(SPM.xY.P{1,n},'C:\Users\Zhongxu\Documents','D:')
end
for n = 1:20
SPM.xY.VY(n,1).fname= strrep(SPM.xY.VY(n,1).fname,'C:\Users\Zhongxu\Documents','D:')
end