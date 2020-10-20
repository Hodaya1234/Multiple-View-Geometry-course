load('data.mat');
x={K\x{1},K\x{1}};
%%
[~ ,res_before] = ComputeReprojectionError(P,X,x);
%%
iterations=50;
lambdas=[0.01,1,100];
n=length(lambdas);
errs=cell(1,n);
residuals=cell(1,n);
%%
for i=1:length(lambdas)
    [err, f_err, res] = optimize_XP( P,X,x,iterations,lambdas(i));
     errs{i}=err;
     residuals{i}=res;
end
%%
for i=1:n
subplot(1,n,i)
semilogy(errs{i})
xlabel('Iteration')
if i==1
ylabel('log error')
end
title(['\lambda=', num2str(lambdas(i))])
end
%%
figure;
subplot(1,4,1)
hist(res_before,10)
title('Residuals before')
for i=2:4
subplot(1,4,i)
hist(residuals{i-1},10)
title(['\lambda=', num2str(lambdas(i-1))])
end