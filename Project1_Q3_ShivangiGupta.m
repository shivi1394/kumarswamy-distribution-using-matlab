clc; clear all; format compact;
%SHIVANGI GUPTA
%% Problem 2 - Kumaraswamy Distribution
clc; clear all; format compact;

a = 5;
b = 3;
sample_num = 10000;

%Kumaraswamy Distribution
kumar_dist = @(x) (a.* b).*(power(x, a - 1).*power(1 - power(x,a),b - 1));

%Inverse of cdf of Kumaraswamy distribution
inv_cdf = @(u) power(1 - power(1 - u, 1 /b), 1/a);

% Generate samples from a uniform distribution
uni_samples = rand(sample_num, 1);

% Apply the inverse CDF to the uniform samples to get kumaraswamy samples
kumar_samples = inv_cdf(uni_samples);


%Vector of a values
a_vec = linspace(0,15,sample_num);
b_vec =[];

for a_param = a_vec
    b_vec(end+1) = -(sample_num)./(sum(log(1-power(kumar_samples,a_param))));
end

likelihood = [];

for i = 1:sample_num
    t1 = sample_num.*(log(a_vec(i)) + log(b_vec(i)));
    t2 = (a_vec(i)-1).*sum(log(kumar_samples));
    t3 = (b_vec(i)-1).*sum(log(1-power(kumar_samples,a_vec(i))));
    likelihood(end+1) = t1+ t2 +t3;
end

index = find(likelihood==max(likelihood));

a_mle = a_vec(index);
b_mle = b_vec(index);

fprintf('The value of a is %f \n',a_mle);
fprintf('The value of b is %f \n',b_mle);




