function [filledin] = Filling(data,greymatter)
    mysize = size(data);
    Index = [0,0,0];
    label = zeros(mysize);
    n = 1;
    for i=1:mysize(1)
        for j=1:mysize(2)
            for k=1:mysize(3)
                if data(i,j,k) == 1
                       Index(n,:) =[i,j,k];   
                       n = n+1;
                end
            end
        end
    end
    Myshape = alphaShape(Index);

    for i=1:mysize(1)
        for j=1:mysize(2)
            for k=1:mysize(3)
                if greymatter(i,j,k) > 0 && inShape(Myshape,i,j,k)
                       label(i,j,k) =1;  
                end
            end
        end
    end
    return filledin;
end
