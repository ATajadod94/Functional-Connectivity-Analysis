function stats=picpairbartable(data, data_error,groupnames,bw_legend,bw_xlabel,bw_ylabel,shw_point,orig_data,shwdata,shwsig,locationString)

width = 1;
bw_title=[];

bw_color_map = [.3 .3 .3 ;.8 0.8 0.8];
gridstatus = 'none'
error_sides = 1;
legend_type = 'plot';
hb=barwebpicpair(data,data_error,width, groupnames, bw_title, bw_xlabel, bw_ylabel, bw_color_map, gridstatus, bw_legend, error_sides, legend_type,8,locationString);
axis on
hold on
set(gca,'Color','w');
set(gca,'LineWidth',1);
set(gca,'TickLength',[.01 .025]);


if ~isempty(shw_point)& shwdata==1
    data_point=reshape(orig_data,size(orig_data,1)*size(orig_data,2),size(orig_data,3))';
    for i = 1:length(shw_point)
        if mod(i,2)==1
            
            scatter(ones(size(orig_data,3),1)*shw_point(i),data_point(:,i)',5,'o','filled','MarkerFaceColor',bw_color_map(1,:),'MarkerEdgeColor','k');
            
        else
            scatter(ones(size(orig_data,3),1)*shw_point(i),data_point(:,i)',5,'o','filled','MarkerFaceColor',bw_color_map(2,:),'MarkerEdgeColor','k');
        end
    end
    tval=[];
    pval=[];
    df=[];
end

if shwsig==1
    star_loc=reshape(shw_point,2,length(shw_point)/2);
    
    for i = 1:size(orig_data,2)
        [H,P,CI,STATS] = ttest(squeeze(orig_data(1,i,:)),squeeze(orig_data(2,i,:)));
        pval(i)=P;
        tval(i)=STATS.tstat;
        df(i)=STATS.df;
        
        x=mean(star_loc(:,i));
        x1=x+.1;
        y=1.2*max(nanmean(orig_data(:,i,:),3));
        if y>1;y=1;end;
        if y<.3;y=.3;end;
        mksize=10;
        
        if pval(i)<.01
            
            scatter(x,y,mksize,'k*');
            scatter(x1,y,mksize,'k*');
            
        elseif pval(i)<.05 && pval(i)>.01
            scatter(x,y,mksize,'k*');
            
        elseif pval(i)<.1 && pval(i)>.05
            scatter(x,y,mksize,'k+');
            
        end
        
    end
    
   stats=[tval;pval;df]; 
end
