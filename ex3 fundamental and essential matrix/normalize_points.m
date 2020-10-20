function [ norm_matrices, norm_x ] = normalize_points( x )
%NORMALIZE_POINTS standartize a two sets of corresponding points.
% Input: a (1,2) cell array of the two sets of points.
% Output: a (1,2) cell array of norm matrices, and a (1,2) cell array of
% the normalized points.

norm_matrices = cell(1,2);
norm_x = cell(1,2);
for i=[1,2]
   orig_x = x{i};
   m = mean(orig_x(1:2,:),2);
   s = std(orig_x(1:2,:),1,2);
   N=eye(3);
   N(1:2,3)=N(1:2,3)-m(1:2);
   N(1:2,:)=N(1:2,:)./s(1:2);
   norm_matrices{i}=N;
   norm_x{i}=N*orig_x;
end
end

