b(:,1) = houseRecogFam1.recall + houseRecogFam1.fml +houseRecogFam1.recogInOneNew + houseRecogFam1.recogInBothOld;
c=singleHouse.fam{1};
d=zeros(96,1);
d(c,1) = 1;
b-d



b(:,1) = faceRecogFam2.recall + faceRecogFam2.fml +faceRecogFam2.recogInOneNew + faceRecogFam2.recogInBothOld;
c=singleFace.fam{2};
d=zeros(96,1);
d(c,1) = 1;
b-d



b(:,1) = intactRecogFam1;
c=intact.fam{1};
d=zeros(96,1);
d(c,1) = 1;
b-d

b(:,1)= recomRecogNFam1(:,3);
c=recom.nfam{1};
d=zeros(96,1);
d(c,1) = 1;
b-d