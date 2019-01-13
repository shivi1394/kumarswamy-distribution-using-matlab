clc; clear all; format compact;
%SHIVANGI GUPTA
%% Problem 1 - Kumaraswamy Distribution
clc; clear all; format compact;

a = 5;
b = 3;
num_of_samples = 10000;

%Kumaraswamy Distribution
kumar_dist = @(x) (a.* b).*(power(x, a - 1).*power(1 - power(x,a),b - 1));


%CDF of Kumaraswamy distribution 
cdf = @(x) 1 - power(1 - power(x,a),b);

%Inverse of cdf of Kumaraswamy distribution
inv_cdf = @(u) power(1 - power(1 - u, 1 /b), 1/a);


% Generate samples from a uniform distribution
uni_samples = rand(num_of_samples, 1);
                    
% Apply the inverse CDF to the uniform samples
kumar_samples = inv_cdf(uni_samples);

% Plot Data
figure(1)
histogram(kumar_samples, 'Normalization', 'pdf')
hold on
t = linspace(min(kumar_samples), max(kumar_samples), 10000);
plot(t, kumar_dist(t), 'LineWidth', 2)
hold off
title('Kumaraswamy Distribution')
legend('Kumaraswamy Histogram', 'Kumaraswamy PDF','Location','northwest')
grid on