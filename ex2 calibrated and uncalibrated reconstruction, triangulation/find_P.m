function [ P,proj_x,smallest_sing ] = find_P( X,x,N )
%FIND_P Summary of this function goes here
%   Detailed explanation goes here

n=size(X,2);
M = zeros(3*n,12+n);
norm_points = N*x;
for i=1:n
   for j=0:2
       M(3*(i-1)+j+1, 1+j*4:(j+1)*4)=[X(:,i);1]';
   end
   M((i-1)*3+1:i*3,12+i)=norm_points(:,i);
end

[U,S,V] = svd(M);
smallest_sing = S(min(size(S)),min(size(S)));
sol=V(:,end);
P = N\reshape(sol(1:12),[4 3])';
proj_x = pflat(P*[X;ones(1,n)]);

end

