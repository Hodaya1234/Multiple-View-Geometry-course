load('compEx3data.mat');
im1 = imread('cube1.JPG');
im2 = imread('cube2.JPG');
%%
norm_points=cell(1,2);
norm_matrices = cell(1,2);
for i=[1,2]
   points = x{i};
   N=eye(3);
   N(1:2,3) = -mean(points(1:2 ,:),2);
   N(1,:) = N(1,:)./std(points(1,:),0,2);
   N(2,:) = N(2,:)./std(points(2,:),0,2);
   norm_points{i}=N*points;
   norm_matrices{i} = N;
end
%%
for i=[1,2]
   scatter(norm_points{i}(1,:),norm_points{i}(2,:),'.');
   hold on
end
axis equal
%%
Ps = cell(1,2);
proj_x = cell(1,2);
sing = cell(1,2);
for i=1:2
   [Ps{i},proj_x{i},sing{i}]=find_P(Xmodel,x{i},norm_matrices{i});
end
%%
for i=1:2
   P=Ps{i};
   scatter(proj_x{i}(1,:),proj_x{i}(2,:),'.')
   hold on
end
axis equal
%%
subplot(1,2,1)
image(im1)
hold on
scatter(proj_x{1}(1,:),proj_x{1}(2,:),'*','w')
scatter(x{1}(1,:),x{1}(2,:),'.','k')
subplot(1,2,2)
image(im2)
hold on
scatter(proj_x{2}(1,:),proj_x{2}(2,:),'*','w')
scatter(x{2}(1,:),x{2}(2,:),'.','k')
legend({'projected','given'})
%%
scatter3(Xmodel(1,:),Xmodel(2,:),Xmodel(3,:))
hold on
centers = [pflat(null(Ps{1})), pflat(null(Ps{2}))];
centers = centers(1:3,:);
paxis = [-Ps{1}(3,1:3)', -Ps{2}(3,1:3)'];
quiver3(centers(1,:),centers(2,:),centers(3,:), paxis(1,:), paxis(2,:), paxis(3,:))
axis equal
%%
K=rq(Ps{1});
K=K./K(3,3);
%% RMS
rms1 = rms(proj_x{1}(1:2,:)'-x{1}(1:2,:)');
[~,proj_x2,~]=find_P(Xmodel,x{1},eye(3));
rms2 = rms(proj_x2(1:2,:)'-x{1}(1:2,:)');

points_indices = [1,4,13,16,25,28,31];
new_x = x{1}(:,points_indices);
new_X = Xmodel(:,points_indices);
[~,proj_x3,~]=find_P(new_X,new_x,norm_matrices{1});
[~,proj_x4,~]=find_P(new_X,new_x,eye(3));
rms3 = rms(proj_x3(1:2,:)'-new_x(1:2,:)');
rms4 = rms(proj_x4(1:2,:)'-new_x(1:2,:)');

