function [ params, all_errors, rms_error ] = compute_plane( X )
%COMPUTE_PLANE Summary of this function goes here
%   Detailed explanation goes here
X_center=X(1:3,:)-mean(X(1:3,:),2);
M=X_center*X_center';
[V,~]=eig(M);
%%
abc = V(:,1);
d=-abc'*mean(X(1:3,:),2);
params=[abc;d];
%%
all_errors=params'*X;
rms_error=sqrt(mean(all_errors.^2));

end

