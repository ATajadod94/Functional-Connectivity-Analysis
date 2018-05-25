function g = gkgammatst(x,alpha,tail)
%GKGAMMA Goodman-Kruskal's gamma test. It is an inference on the measure of
% correlation among two ordered qualitative variables. Measuring strength 
% of association of cross tabulated data. It was proposed by Leo Goodman 
% and William Kruskal across a series of papers (1954, 1959, 1963 and 
% 1972).
%
% A pair of observations is concordant if the subject who is higher on one
% variable also is higher on the other variable, and a pair of observations
% is discordant if the subject who is higher on one variable is lower on 
% the other variable (Goktas and Qznur, 2011).
%
% If C > D the variables have a positive association, but if C < D then the
% variables have a negative association. C and D are, respectivelly, the 
% total number of concordances and discordances.
%
% The ratio (C - D)/(C + D) is the Goodman-Kruskal´s gamma statistic (g). 
% It can lie between -1 and 1. Sign indicates if ther is a negative or
% positive association. The magnitude indicates strength of association.
%
% The asymtotic Goodman-Kruskal's gamma variance is calculated as,
%
%   varg = 4/(C + D)^2*(Sum_i Sum_j n_ij*((A_ij - B_ij)^2 - (C - D)^2/n)
%
% where,
%            A_ij = Sum_k<i Sum_l<j a_kl + Sum_k>i Sum_l>j a_kl
%
%            B_ij = Sum_k>i Sum_l<j a_kl + Sum_k<i Sum_l>j a_kl
%
% a_ij denote the observed frequency in cell (i,j) in an I x J contingency 
% table.
%
% Concordances, C is:    C = Sum_i Sum_j a_ij*A_ij
%
% Discordances, D is:    D = Sum_i Sum_j a_ij*B_ij
%
% The z-value = g/sqrt(varg)
%
% Null hypothesis: no association (no relationship or independence) 
% corresponding gamma = 0. Alternative hypothesis (one-sided) gamma < 0 or 
% gamma > 0.
%
% Syntax: function gkgammatst(x,alpha,tail)
%
% Inputs:
%      x – rxc data matrix 
%  alpha - significance value (default=0.05)
%   tail - two-sided=0; one-sided~=0
%
% Output:
%        - Summary statistics from the analysis
%
% Example. We take the example given in the Lecture 14 of Simon Jackman's
% Political Science 151B course, Stanford University. Where there is the
% interest to found and make a statistical inference on the relationship
% between the job satisfaction and income for a sample of 104 black 
% americans [URL address http://jackman.stanford.edu/classes/151B/06/
% Lecture14.pdf]. As you can see, the categorical (qualitative) independent
% variables (Job satisfaction and Income) are ordered. We use an one tailed
% test and alpha-value of 0.05. Data are: 
%    
%        ------------------------------------------------------
%                                  Job satisfaction
%        ------------------------------------------------------
%                                     Moderately     Very
%          Income        Dissatisfied  satisfied   satisfied
%        ------------------------------------------------------
%          < 5000             6           13           3
%         5000-25000          9           37          12
%          > 25000            3           13           8
%        ------------------------------------------------------
%
% Input data:
% x = [6 13 3;9 37 12;3 13 8];
%
% Calling on Matlab the function: 
%                gkgammatst(x,0.05,1)
%
% Answer is:
% ---------------------------------------------------------------------------------------
% Sample size: 104
% Contingency table: 3 x 3
% Goodman-Kruskal's gamma statistic: 0.2873
% Goodman-Kruskal's asymtotic standard error: 0.1506
% z-value: 1.9081
% Sample size: 104
% P-value associated to the Goodman-Kruskal's gamma statistic: 0.0282
% In a one-sided test:
% With a given significance = 0.050
% There is a significant positive relationship between the ordered qualitative variables.
% ---------------------------------------------------------------------------------------
%
% Created by A. Trujillo-Ortiz and R. Hernandez-Walls
%           Facultad de Ciencias Marinas
%           Universidad Autonoma de Baja California
%           Apdo. Postal 453
%           Ensenada, Baja California
%           Mexico.
%           atrujo@uabc.edu.mx
%
% Copyright (C) July 7, 2013. 
%
% To cite this file, this would be an appropriate format:
% Trujillo-Ortiz, A. and R. Hernandez-Walls. (2013). gkgammatst: 
%    Goodman-Kruskal's gamma test. [WWW document]. URL address  
%    http://www.mathworks.com/matlabcentral/fileexchange/42645-gkgammatst
%
% References:
% Goktas, A. and Oznur, I. (2011). A comparision of the most commonly used
%              measures of association for doubly ordered square 
%              contingency tables via simulation. Metodoloski zvezki 8(1):
%              17-37. (URL address: www.stat-d.si/mz/mz8.1/goktas.pdf)
% Goodman, L. A. and Kruskal, W. H. (1954). Measures of association for
%              cross classifications. Journal of the American Statistical 
%              Association, 49:732-764.
% Goodman, L. A. and Kruskal, W. H. (1959). Measures of association for
%              cross classifications II:Further Discussion and References.
%              Journal of the American Statistical Association, 54:123-163.
% Goodman, L. A. and Kruskal, W. H. (1963). Measures of association for
%              cross classifications III: Approximate Sampling Theory.
%              Journal of the American Statistical Association, 58:310-364.
% Goodman, L. A. and Kruskal, W. H. (1972). Measures of association for
%              cross classifications IV: Simplification of Asymptotic 
%              Variances. Journal of the American Statistical Association, 
%              67:415-421.
%

if nargin < 2 || isempty(alpha)
    alpha = 0.05;
elseif ~isscalar(alpha) || alpha <= 0 || alpha >= 1
    error('stats:gkgammatst:BadAlpha','ALPHA must be a scalar between 0 and 1.');
end
if nargin < 3 || isempty(tail)
    tail = 0;
else
    tail ~= 0;
end

[r,c] = size(x);

[R,C] = ndgrid(1:r,1:c);  %We thank Matt J for this machine

n = sum(sum(x)); %sample size

con = zeros(r,c); %concordances pairs
dis = zeros(r,c); %discordances pairs
for i = 1:r,
    for j = 1:c,
        con(i,j) =  sum(x(R < i & C < j)) + sum(x(R > i & C > j));
        dis(i,j) =  sum(x(R < i & C > j)) + sum(x(R > i & C < j));
    end
end

C = sum(sum(x.*con))/2; %total of concordances
D = sum(sum(x.*dis))/2; %total of discordances

g = (C - D)/(C + D); %Goodman-Kruskal's gamma statistic

psi = 2*(D*con-C*dis)/(C+D)^2;
s2 = sum(sum(x.*psi.^2)) - sum(sum((x.*psi)))^2; %Goodman-Kruskal's gamma variance
se = sqrt(s2); %Goodman-Kruskal's asymtotic standard error
z = g/se; %inference via z-score

if tail == 0
    p = 2*(1 - normcdf(abs(z))); %p-value (two-sided)
else
    p = 1 - normcdf(abs(z)); %p-value (one-sided)
end
    
disp('---------------------------------------------------------------------------------------')
fprintf('Sample size: %i\n', n);
fprintf('Contingency table: %i x %i\n', r, c);
fprintf('Goodman-Kruskal''s gamma statistic: %3.4f\n', g);
fprintf('Goodman-Kruskal''s asymtotic standard error: %3.4f\n', se);
fprintf('z-value: %3.4f\n', z);
fprintf('P-value associated to the Goodman-Kruskal''s gamma statistic: %3.4f\n', p);
if tail == 0
    disp('In a two-sided test:');
else
    disp('In a one-sided test:');
end
fprintf('With a given significance = %3.3f\n', alpha);
if p >= alpha;
    disp('There is not a significant relationship between the ordered qualitative variables.');
else
    if g >= 0
        disp('There is a significant positive relationship between the ordered qualitative variables.');
    else
        disp('There is a significant negative relationship between the ordered qualitative variables.');
    end
end
disp('---------------------------------------------------------------------------------------')

return, 