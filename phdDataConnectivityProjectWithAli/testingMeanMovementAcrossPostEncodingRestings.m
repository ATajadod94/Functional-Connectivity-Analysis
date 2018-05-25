% test mean movement difference between restings
% translations are not different across 3 restings
% rotations were larger in post-nonfam than preencoding rest, but postfam
% and postnonfam restings were similar p > .10.
% taking out participant 2 5 6 20, the prebaseline rest rotation could be
% comparable to the post nonfam resting.


for i = 1:20
dataDir1=['D:\myStudy\picpairfMRI\s', sprintf('%03d',i),'\prepostEncoding\preBaseline\'];
dataDir2=['D:\myStudy\picpairfMRI\s', sprintf('%03d',i),'\prepostEncoding\postFam\'];
dataDir3=['D:\myStudy\picpairfMRI\s', sprintf('%03d',i),'\prepostEncoding\postNonFam\'];

motion1 = textread([dataDir1,'rp_avol_0004-180.txt']);
motion2 = textread([dataDir2,'rp_avol_0004-180.txt']);
motion3 = textread([dataDir3,'rp_avol_0004-180.txt']);

moall1(:,:,i)=motion1;
moall2(:,:,i)=motion2;
moall3(:,:,i)=motion3;

transData1(i) =mean(sqrt( motion1(:,1).^2 +motion1(:,2).^2 +motion1(:,3).^2)); 
transData2(i) =mean(sqrt( motion2(:,1).^2 +motion2(:,2).^2 +motion2(:,3).^2)); 
transData3(i) =mean(sqrt( motion3(:,1).^2 +motion3(:,2).^2 +motion3(:,3).^2)); 
rotatData1(i) = mean(acos((cos(motion1(:,4)).*cos(motion1(:,5))+cos(motion1(:,4)).*cos(motion1(:,6))+...
    cos(motion1(:,5)).*cos(motion1(:,6))+sin(motion1(:,4)).*sin(motion1(:,6)).*sin(motion1(:,5))-1)/2));

rotatData2(i) = mean(acos((cos(motion2(:,4)).*cos(motion2(:,5))+cos(motion2(:,4)).*cos(motion2(:,6))+...
    cos(motion2(:,5)).*cos(motion2(:,6))+sin(motion2(:,4)).*sin(motion2(:,6)).*sin(motion2(:,5))-1)/2));

rotatData3(i) = mean(acos((cos(motion3(:,4)).*cos(motion3(:,5))+cos(motion3(:,4)).*cos(motion3(:,6))+...
    cos(motion3(:,5)).*cos(motion3(:,6))+sin(motion3(:,4)).*sin(motion3(:,6)).*sin(motion3(:,5))-1)/2));


rotatRMS1(i) =mean(sqrt( motion1(:,4).^2 +motion1(:,5).^2 +motion1(:,6).^2)); 
rotatRMS2(i) =mean(sqrt( motion2(:,4).^2 +motion2(:,5).^2 +motion2(:,6).^2)); 
rotatRMS3(i) =mean(sqrt( motion3(:,4).^2 +motion3(:,5).^2 +motion3(:,6).^2)); 
end

max(max(max(moall1(:,4:6,:)))*180)
max(max(max(moall1(:,1:3,:))))

max(max(max(moall2(:,4:6,:)))*180)
max(max(max(moall2(:,1:3,:))))

max(max(max(moall3(:,4:6,:)))*180)
max(max(max(moall3(:,1:3,:))))
mean([transData1;transData2;transData3],2)
mean([rotatData1;rotatData2;rotatData3],2)*180

[a b c d]=ttest(transData1,transData2)
[a b c d]=ttest(rotatData1,rotatData2)
[a b c d]=ttest(rotatRMS2,rotatRMS3);
r1=rotatData1;
r1([2 5 6 20])=[];
r3=rotatData3;
r3([2 5 6 20])=[];
[a b c d]=ttest(r1,r3)
