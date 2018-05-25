function [faceMem houseMem pairMem memPCA]= concatenatePerformanceData(data)

nSubj = size(data(:),1);

for i = 1: nSubj
    faceMemFields = fieldnames(data{i}.face);
    houseMemFields = fieldnames(data{i}.house);
    pairMemFields = fieldnames(data{i}.pair);
    % face memory
    for j = 1:size(faceMemFields,1)
        [faceMem.(faceMemFields{j})(i,1)] = data{i}.face.(faceMemFields{j});
    end
    % house memory
    for j = 1:size(houseMemFields,1)
        [houseMem.(houseMemFields{j})(i,1)] = data{i}.house.(houseMemFields{j});
    end
    % pair memory
    for j = 1:size(pairMemFields,1)
        [pairMem.(pairMemFields{j})(i,1)] = data{i}.pair.(pairMemFields{j});
    end
end
memPCA = [faceMem.totalFam, faceMem.totalNFam,...
houseMem.totalFam, houseMem.totalNFam,...
pairMem.intactFam, pairMem.intactNFam,pairMem.recomFam,pairMem.recomNFam];
