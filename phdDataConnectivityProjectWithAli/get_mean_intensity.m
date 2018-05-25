function gl = get_mean_intensity(P)
% Integrate the values in an image.
if nargin<1,
         P = spm_get(Inf,'*.img');
end;
V = spm_vol(P);
gl = zeros(length(V),1);
for i=1:length(gl),
         for z=1:V(i).dim(3),
                 img   = spm_slice_vol(V(i),...
                         spm_matrix([0 0 z]),V(i).dim(1:2),0);
                 gl(i) = gl(i) + sum(img(:));
                 fprintf('.');
         end;
         gl(i) = gl(i)/prod(V(i).dim(1:3));
         fprintf('\n');
end;