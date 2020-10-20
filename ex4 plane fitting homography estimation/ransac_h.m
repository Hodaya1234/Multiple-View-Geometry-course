function [ best_H, highest_agreement ] = ransac_h( x1,x2 )
%RANSAC_H Summary of this function goes here
%   Detailed explanation goes here
n=size(x1,2);
k=10;
best_H=0;
highest_agreement = 0;
for i=1:k
    rand_ind = randperm(n,4);
    x1_rand = x1(:,rand_ind);
    x2_rand = x2(:,rand_ind);
    H = compute_h(x1_rand, x2_rand);
    inliers=sqrt(sum((x2-pflat(H*x1)).^2,1)) <= 5;
    agreement = mean(inliers);
    if agreement > highest_agreement
       highest_agreement=agreement;
       best_H=H;
    end
end
end

