clc; clear all; format compact;
%SHIVANGI GUPTA
%% Problem 4
clc; clear all; format compact;

% Load the binary files into MATLAB
load('project1_testing.mat')
load('project1_training.mat')

% Sort each member of the training data into their respective groups.
group1Ind = find(training_data(:, 2) == 1);
group2Ind = find(training_data(:, 2) == 2);
group3Ind = find(training_data(:, 2) == 3);

% Store the groups in appropriately named variables
group1 = training_data(group1Ind, 1);
group2 = training_data(group2Ind, 1);
group3 = training_data(group3Ind, 1);

% The testing data is called testing_data
testing_data = testing_data;

%Kumaraswamy Distribution
kumar_dist = @(x,a,b) (a.* b).*(power(x, a - 1).*power(1 - power(x,a),b - 1));

%Maximum Likelihood function
Likelihood = @(x,a,b,n) n.*log(a.*b) + (a-1).*sum(log(x)) + (b-1).*sum(log(1-power(x,a)));

%------------------------------------------------------------------------
%Estimating a1 and b1 for Training data belonging to Group 1

num_sample1 = numel(group1);

%Creating a1 vector to estimate b1
a1_vec = linspace(0,15,num_sample1);
b1_vec = [];

%Estimating b1
for a1 = a1_vec
    b1_vec(end+1) = -(num_sample1)./(sum(log(1-power(group1,a1))));
end

likelihood1 = [];

%Computing likelihood of the samples of Group 1
for i = 1:num_sample1
    likelihood1(end+1) = Likelihood(group1,a1_vec(i),b1_vec(i),num_sample1);
end

index1 = find(likelihood1==max(likelihood1));

%Value of a1 and b1
a1_mle = a1_vec(index1);
b1_mle = b1_vec(index1);

fprintf('The value of a1 is %f \n',a1_mle);
fprintf('The value of b1 is %f \n\n',b1_mle);
%--------------------------------------------------------------------------

%Estimating a2 and b2 for Training data belonging to Group 2

num_sample2 = numel(group2);

%Creating a2 vector to estimate b2
a2_vec = linspace(0,15,num_sample2);
b2_vec = [];

%Estimating b2
for a2 = a2_vec
    b2_vec(end+1) = -(num_sample2)./(sum(log(1-power(group2,a2))));
end

likelihood2 = [];

%Computing likelihood of the samples of Group 2
for i = 1:num_sample2
    likelihood2(end+1) = Likelihood(group2,a2_vec(i),b2_vec(i),num_sample2);
end

index2 = find(likelihood2==max(likelihood2));

%Value of a2 and b2
a2_mle = a2_vec(index2);
b2_mle = b2_vec(index2);

fprintf('The value of a2 is %f \n',a2_mle);
fprintf('The value of b2 is %f \n\n',b2_mle);

%--------------------------------------------------------------------------

%Estimating a3 and b3 for Training data belonging to Group 3

num_sample3 = numel(group3);

%Creating a3 vector to estimate b3
a3_vec = linspace(0,15,num_sample3);
b3_vec = [];

%Estimating b3
for a3 = a3_vec
    b3_vec(end+1) = -(num_sample3)./(sum(log(1-power(group3,a3))));
end

likelihood3 = [];

%Computing likelihood of the samples of Group 3
for i = 1:num_sample3
    likelihood3(end+1) = Likelihood(group3,a3_vec(i),b3_vec(i),num_sample3);
end

index3 = find(likelihood3==max(likelihood3));

%Value of a3 and b3
a3_mle = a3_vec(index3);
b3_mle = b3_vec(index3);

fprintf('The value of a3 is %f \n',a3_mle);
fprintf('The value of b3 is %f \n\n',b3_mle);

%--------------------------------------------------------------------------
%Classifying the testing data into group 1 , group 2 and group 3

group_1 = [];
group_2 = [];
group_3 = [];

sample_size = numel(testing_data);

for i = 1:sample_size
    %Calculating pdf of testing data using the computed parameters
    p1 = kumar_dist(testing_data(i),a1_mle,b1_mle);
    p2 = kumar_dist(testing_data(i),a2_mle,b2_mle);
    p3 = kumar_dist(testing_data(i),a3_mle,b3_mle);
    
    %Creating an array of pdf 
    pdf = [p1, p2, p3];
    
    %Calculating the index of the closest value from the MLE
    index_of_max = find(pdf == max(pdf));
    
    %Classifying the data
    if(index_of_max == 1)
        group_1(end+1) = testing_data(i);
    elseif(index_of_max == 2)
        group_2(end+1) = testing_data(i);
    elseif(index_of_max == 3)
        group_3(end+1) = testing_data(i);
    end
    
end

s1 = numel(group_1);
s2 = numel(group_2);
s3 = numel(group_3);

fprintf('Number of points classified as group 1 : %d \n',s1);
fprintf('Number of points classified as group 2 : %d \n',s2);
fprintf('Number of points classified as group 3 : %d \n',s3);
%--------------------------------------------------------------------------
    
    
    
    







