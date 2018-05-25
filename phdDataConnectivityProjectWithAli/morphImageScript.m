load trees;
A = ind2rgb(X,map);
B=rand(size(A));
diffmat=(B-A)/100;
figure('doublebuffer','on','units','normalized');
imshow(A);
set(gcf,'position',[0.1 0.1 0.8 0.8]);
for ii=1:99
A=A+diffmat;
set(get(gca,'children'),'cdata',A);
drawnow
end
set(get(gca,'children'),'cdata',B);
B=ind2rgb(X,map);diffmat=(B-A)/100;
for ii=1:99
A=A+diffmat;
set(get(gca,'children'),'cdata',A);
drawnow
end
set(get(gca,'children'),'cdata',B);