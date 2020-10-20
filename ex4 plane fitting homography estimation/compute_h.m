function H = compute_h(x1,x2)

    n = size(x1,2);
    M = zeros(3*n, 9+n);
    for i=1:n
        M(3*i-2,1:3)=x1(:,i)';
        M(3*i-1,4:6)=x1(:,i)';
        M(3*i,7:9)=x1(:,i)';
        M(3*i-2:3*i,i+9) = -x2(:,i);
    end
    [~, ~, V] = svd(M);
    H = V(:,end);  
    H = reshape(H(1:9),[3 3])';

end

