function [ best_plane, best_inliers, rmse, all_errors ] = ransac_plane( X,k )
%RANSAC Summary of this function goes here
%   Detailed explanation goes here
n=size(X,2);
best_plane=0;
highest_agreement = 0;
for i=1:k
    rand_ind = randperm(n,3);
    plane = null(X(:, rand_ind )');
    plane = plane./norm(plane(1:3));
    inliers=abs(plane'*X) <= 0.1;
    agreement = mean(inliers);
    if agreement > highest_agreement
       highest_agreement=agreement;
       best_inliers=inliers;
       best_plane=plane;
       all_errors=plane'*X;
       rmse=sqrt(mean(all_errors.^2));
    end
end
end

