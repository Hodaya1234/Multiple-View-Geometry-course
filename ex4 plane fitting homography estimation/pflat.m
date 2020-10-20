function [ rpoints ] = pflat( hpoints )
% project points from homogenous coordinates in P^n to euclidean points in
% R^n. Assume the input is n X #points
n = size(hpoints,1);
last_row = hpoints(end ,:); 
rpoints = hpoints./repmat(last_row ,[n 1]);

end

