function plot_images(X,x,P1,P2, im1,im2 )
%PLOT_IMAGES Summary of this function goes here
%   Detailed explanation goes here

proj_x1=pflat(P1*X);
proj_x2=pflat(P2*X);
figure;
subplot(1,2,1)
image(im1)
hold on
scatter(proj_x1(1,:),proj_x1(2,:),'.')
scatter(x{1}(1,:),x{1}(2,:),'LineWidth', 0.5)
subplot(1,2,2)
image(im2)
hold on
scatter(proj_x2(1,:),proj_x2(2,:),'.')
scatter(x{2}(1,:),x{2}(2,:),'LineWidth', 0.5)
legend({'Projected', 'Given'})
end

