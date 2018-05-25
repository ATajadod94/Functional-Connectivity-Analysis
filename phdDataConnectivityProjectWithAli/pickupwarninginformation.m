function pickupwarninginformation
vector_input=[0 1 0]';
vector_output= -100*ones(size(vector_input));
number_warnings=0;

for k=1:size(vector_input,1)
%      warning on MATLAB:nearlySingularMatrix;
    vector_output(k)=inv( vector_input(k));
    [msglast, msgidlast] = lastwarn;
   if strcmp(msgidlast,'MATLAB:singularMatrix')
        number_warnings=number_warnings+1;
    end
    s = warning('off','all'); % turn display of all warnings off
    warning('FineId','fine') % becomes the last warning
    warning(s) % turn display of all warnings on
end
