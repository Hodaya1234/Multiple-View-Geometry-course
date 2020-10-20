function [ F,U,V ] = compute_f( x,essential, standard )
%COMPUTE_F Calculate the fundamental matrix with the 8 point algorithm.
n=size(x{1},2);
if standard
    [norm_matrices, norm_x] = normalize_points(x);
    x1=norm_x{1};
    x2=norm_x{2};
else
    x1=x{1};
    x2=x{2};
    norm_matrices = {eye(3),eye(3)};
    
end
M=zeros(n,9);
for i=1:n
   xx=x2(:,i)*x1(:,i)';
   M(i ,:)=xx(:)';
end
[~, ~, V] = svd(M);
F = reshape(V(:,end),[3,3]);
[U, S, V] = svd(F);
disp(S(3,3))
if essential
    s = (S(1,1)+S(2,2))/2;
    S=diag([s s 0]);
    if det(U*V')<=0
        V = -V;
    end
    F = U*S*V';
else
    S(3,3)=0;
    F=U*S*V';
end

F = norm_matrices{2}'*F*norm_matrices{1};
end

