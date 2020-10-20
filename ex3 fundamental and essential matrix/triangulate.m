function [ X ] = triangulate(Ps,x, standard )
%TRIANGULATE Summary of this function goes here
%   Detailed explanation goes here

n=size(x{1},2);
if standard
   [norm_matrices, norm_x] = normalize_points(x);
   x=norm_x;
   Ps{1}=norm_matrices{1}*Ps{1};
   Ps{2}=norm_matrices{2}*Ps{2};
end
X=zeros(4,n);
for i=1:n
%     M=zeros(6,6);
%     M(1:3,1:4)=Ps{1};
%     M(4:6,1:4)=Ps{2};
%     M(1:2,5)=x{1}(1:2,i);
%     M(3,5)=1;
%     M(4:5,6)=x{2}(1:2,i);
%     M(6,6) = 1;
        M = [Ps{1}, -x{1}(:,i) ,zeros(3,1)  ;...
            Ps{2} , zeros(3,1) ,-x{2}(:,i)];
    [~,~,V]=svd(M);
    v=V(:,end);
    X(:,i) = pflat(v(1:4,:));
end

end

