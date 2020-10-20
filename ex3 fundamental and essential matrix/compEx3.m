load('compEx1data.mat')
load('compEx3data.mat')
im1 = imread('kronan1.JPG');
im2 = imread('kronan2.JPG');
%%
calib_x={K\x{1},K\x{2}};
%%
[E,U,V]=compute_f(calib_x,1,0);
F=inv(K)'*E*inv(K);
disp(round(E./E(3,3),2))
disp(round(F./F(3,3),2))
% E=E./E(3,3);
F=F./F(3,3);
%%
subplot(1,2,1)
plot(diag(calib_x{2}'*E*calib_x{1}))
subplot(1,2,2)
plot(diag(x{2}'*F*x{1}))
%%
l = F*x{1};
lines2 = l./sqrt(repmat(l(1,:).^2 + l(2,:).^2 ,[3 1]));
figure;
hist(abs(sum(lines2.*x{2})),100);
mean_distance = mean(abs(sum(lines2.*x{2})));

rand_indices = randperm(size(x{1},2),20);
image_points = x{2}(:,rand_indices);
image_lines = lines2(:,rand_indices);

figure;
image(im2)
hold on
scatter(image_points(1,:),image_points(2,:));
rital(image_lines)

%%
e2 = null(F');
e2x=[0 -e2(3) e2(2); e2(3) 0 -e2(1); -e2(2) e2(1) 0];
P2=[e2x*F, e2];
P1=[eye(3), zeros(3,1)];
X=triangulate({P1,P2},x,1);
plot_images(X,x,P1,P2, im1,im2 )
figure;
scatter3(X(1,:),X(2,:),X(3,:),'.')
%%
cam2 = get_four_cam(E,U,V);
cam1= [eye(3),zeros(3,1)];
Xs=cell(1,4);
for i=1:4
   X=pflat(triangulate({cam1,cam2{i}},calib_x,1));
   Xs{i}=X;
end
%%
proj_1=cell(1,4);
proj_2=cell(1,4);
for i=1:4
   proj_1{i}=cam1*Xs{i};
   proj_2{i}=cam2{i}*Xs{i};
end
%%
figure;
subplot(1,2,1)
for i=1:4
   plot(proj_1{i}(3,:))
   hold on
end
legend({'1','2','3','4'})
subplot(1,2,2)
for i=1:4
   plot(proj_2{i}(3,:))
   hold on
end
legend({'1','2','3','4'})
%%
correct_index=2;
plot_images(Xs{correct_index},x,K*P1,K*cam2{correct_index}, im1,im2 )
%%
[center1, normal1] = find_center_axis(P1);
[center2, normal2] = find_center_axis(cam2{correct_index});
figure;
scatter3(Xs{correct_index}(1,:),Xs{correct_index}(2,:),Xs{correct_index}(3,:),'.')
hold on
quiver3(center1(1),center1(2),center1(3), normal1(1),normal1(2),normal1(3));
quiver3(center2(1),center2(2),center2(3), normal2(1),normal2(2),normal2(3));
