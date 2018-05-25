function [ind]=FdIndexCellstr(yourcellvec,str)

    aa=strfind(yourcellvec,str);
    bb=~cellfun('isempty',aa);
    ind=find(bb==1);
end