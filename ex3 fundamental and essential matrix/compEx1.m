load('compEx1data.mat');
[~,n]=size(x{1});
F = compute_f(x,0,1);
F = F./F(3,3);
%%
figure;
plot(diag(x{2}'*F*x{1}));
title('x_2^TFx_1')
%%
l = F*x{1};
lines2 = l./sqrt(repmat(l(1,:).^2 + l(2,:).^2 ,[3 1]));
figure;
hist(abs(sum(lines2.*x{2})),100);
mean_distance = mean(abs(sum(lines2.*x{2})));
%%
im1 = imread('kronan1.JPG');
im2 = imread('kronan2.JPG');
%%
rand_indices = randperm(size(x{1},2),20);
image_points = x{2}(:,rand_indices);
image_lines = lines2(:,rand_indices);
%%
figure;
image(im2)
hold on
scatter(image_points(1,:),image_points(2,:));
rital(image_lines)
%%
e2 = null(F');
% e2=e2./e2(3);
e2x=[0 -e2(3) e2(2); e2(3) 0 -e2(1); -e2(2) e2(1) 0];
P2=[e2x*F, e2];
P1=[eye(3), zeros(3,1)];
X=triangulate({P1,P2},x,1);
%X=triangulate(P1,P2,x{1},x{2},n);
proj_x1=pflat(P1*X);
proj_x2=pflat(P2*X);
%%
figure;
scatter3(X(1,:),X(2,:),X(3,:),'.')
%%
figure;
subplot(1,2,1)
image(im1)
hold on
scatter(proj_x1(1,:),proj_x1(2,:),'.')
scatter(x{1}(1,:),x{1}(2,:),'MarkerEdgeColor',[1 1 1], 'LineWidth', 0.5)
subplot(1,2,2)
image(im2)
hold on
scatter(proj_x2(1,:),proj_x2(2,:),'.')
scatter(x{2}(1,:),x{2}(2,:),'MarkerEdgeColor',[1 1 1], 'LineWidth', 0.5)
legend({'Projected', 'Given'})
