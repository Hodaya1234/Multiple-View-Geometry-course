load('compEx1data.mat')
im1=imread('house1.jpg');
im2=imread('house2.jpg');
X=pflat(X);
%%
[params, all_errors, rms_error]=compute_plane(X);
%%
[r_plane,ransac_inliers, ransac_error, all_errors]=ransac_plane(X,20);
mean(ransac_inliers)
%%
figure;
hist(abs(all_errors),100)
ylim([0,700])
%%
inliers_X=X(:,ransac_inliers);
[inliers_params, all_errors, inliers_error]=compute_plane(inliers_X);
%%
figure;
hist(abs(all_errors),100)
%%
x1=pflat(P{1}*inliers_X);
x2=pflat(P{2}*inliers_X);
%%
figure;
subplot(1,2,1)
imagesc(im1)
hold on
plot(x1(1,:),x1(2,:),'.')
camroll(90);
subplot(1,2,2)
imagesc(im2)
hold on
plot(x2(1,:),x2(2,:),'.')
camroll(90);
%%
calibP = {K\P{1},K\P{2}}; % already P1=[I 0]
R = calibP{2}(1:3,1:3);
t = calibP{2}(1:3,4);
Pi = pflat(r_plane);
pi_for_h = Pi(1:3);
H = K*(R - t*pi_for_h')*inv(K);
%%
figure;
subplot(1,2,1)
imagesc(im1);
hold on
colormap jet
scatter(x(1,:),x(2,:), 20, linspace(1,64,10), 'filled', 'MarkerEdgeColor',[1 1 1]);
camroll(90);
x2 = pflat(H*x);
subplot(1,2,2)
imagesc(im2);
hold on
colormap jet
scatter(x2(1,:),x2(2,:), 20, linspace(1,64,10),'filled', 'MarkerEdgeColor',[1 1 1]);
camroll(90);
