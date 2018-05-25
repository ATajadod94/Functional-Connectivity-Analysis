% scripts used to test command_line Pls using simulated data
% numParticipants = 20;
% numCondition = 2;
% myRandSeed = 10;
% rng(myRandSeed);

%simulating correlation data (10*10-10)/2=45 between 10 rois for the two conditions 20 participants
datamat_list{1} = randn(40,45);  %condition 1 and 2
datamat_list{1}(21:40,[1:5,11:15, 21:25,31:35,41:45])= .8 + datamat_list{1}(1:20,[1:5,11:15,21:25,31:35,41:45]); %condition 2 somecorrelation larger than condition 1
num_subj_lst = 20;
num_cond = 2;


option.method = 2; %non-rotated
option.num_perm = 500;
option.num_boot = 500;
option.clim = 95;
option.stacked_designdata = [1 -1]'; % I only have one contrast

result = pls_analysis(datamat_list, num_subj_lst, num_cond,option);

