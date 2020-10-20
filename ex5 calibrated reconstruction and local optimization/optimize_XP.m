function [ errors, final_error, final_residuals ] = optimize_XP( Pnew,Xnew,x,iterations,lambda )
%OPTIMIZE Summary of this function goes here
%   Detailed explanation goes here
errors=zeros(1,iterations);
for i=1:iterations
    % Computes the reprejection error and the values of all the residuals
    %for the current solution P,U,u.
    [err ,res] = ComputeReprojectionError(Pnew,Xnew,x);
    % Computes the r and J matrices for the appoximate linear least squares problem .
    [r,J] = LinearizeReprojErr(Pnew,Xnew,x);
    % Computes the LM update .
    C = J'*J+ lambda * speye(size(J ,2));
    c = J'*r;
    deltav = -C\c;
    [Pnew , Xnew ] = update_solution(deltav ,Pnew,Xnew);
    errors(i)=err;
end
final_error=err;
final_residuals=res;
end

