function [ResultMap1,ResultMap2,ResultMap3,ResultMap4,ResultMap5] = restgca_FROI_zxtesting(theROITimeCourses,Order,theCovariables)
         nDim4 = length(theROITimeCourses);
         AX = ones(nDim4-Order,Order);
         BY = ones(nDim4-Order,Order);
           
         theCovariables = [theCovariables(Order+1:end,:),ones(nDim4-Order,1)];
            
         AROITimeCourse_1 = theROITimeCourses(:,1);
         AROITimeCourse_2 = theROITimeCourses(:,2);
         AROITimeCourse_1now = AROITimeCourse_1(Order+1:nDim4);        
         AROITimeCourse_2now = AROITimeCourse_2(Order+1:nDim4);
            
          for k = 1:Order,
              AX(:,k) = AROITimeCourse_1(k:nDim4-Order+k-1);
              BY(:,k) = AROITimeCourse_2(k:nDim4-Order+k-1);
          end
          
          Regressors1 = [BY,theCovariables];
          Regressors2 = [AX,theCovariables];
          Regressors3 = [AX,BY,theCovariables];
          
          Residual_Y = rest_regress(AROITimeCourse_2now,Regressors1);
          Residual_X = rest_regress(AROITimeCourse_1now,Regressors2);
          Residual_X2Y = rest_regress(AROITimeCourse_2now,Regressors3);  
          Residual_Y2X = rest_regress(AROITimeCourse_1now,Regressors3);
          
          F_X2Y = log(Residual_Y/Residual_X2Y); 
          F_Y2X = log(Residual_X/Residual_Y2X);
          F_TX2Y = abs((F_X2Y*(nDim4-Order)-(Order-1)/3)).^0.5;
          F_TY2X = abs((F_Y2X*(nDim4-Order)-(Order-1)/3)).^0.5;
            
          ResultMap1 = F_X2Y;
          ResultMap2 = F_Y2X;
          ResultMap3 = F_TX2Y;
          ResultMap4 = F_TY2X;
          ResultMap5 = F_X2Y-F_Y2X;

          function Residual_var = rest_regress(y,X)
         [n,ncolX] = size(X);
         [Q,R,perm] = qr(X,0);
         p = sum(abs(diag(R)) > max(n,ncolX)*eps(R(1)));       
         if p < ncolX,
            R = R(1:p,1:p);
            Q = Q(:,1:p);
            perm = perm(1:p);
         end
         beta = zeros(ncolX,1);
         beta(perm) = R \ (Q'*y);
% compute the var of residual           
         yhat = X*beta;                     
         residual = y-yhat;
         Residual_var = sum(residual.^2)/(length(residual)-1);
