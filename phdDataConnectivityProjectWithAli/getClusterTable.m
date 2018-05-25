            [xyzmm,i] = spm_XYZreg('NearestXYZ',...
                spm_results_ui('GetCoords'),xSPM.XYZmm);
            spm_results_ui('SetCoords',[58 -32 20]); % define the coordinates

            %-Find selected cluster
            %--------------------------------------------------------------
            A          = spm_clusters(xSPM.XYZ);
            
            j          = find(A == A(i));
            
            % j          = find(A ==8); % define the cluster directly
            xSPM1=xSPM;
            xSPM1.Z     = xSPM1.Z(j);
            xSPM1.XYZ   = xSPM1.XYZ(:,j);
            xSPM1.XYZmm = xSPM1.XYZmm(:,j);
            aaa=spm_list('list',xSPM1)