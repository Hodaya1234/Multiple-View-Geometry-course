%% ex1
load compEx1.mat
points2d = pflat(x2D);
points3d = pflat(x3D);
figure(1)
subplot(1,2,1)
plot (points2d(1 ,:) ,points2d(2 ,:) , '.')
title('Projected Points to 2D')
subplot(1,2,2)
plot3 (points3d(1 ,:) ,points3d(2 ,:) ,points3d(3 ,:) , '.')
title('Projected Points to 3D')
axis equal
%% ex2
image2 = imread('compEx2.JPG');
load compEx2.mat
points = cat(3, p1,p2,p3);
figure(2)
imagesc(image2); colormap gray
hold on
x = 1:size(image2,2);
colors = [1,0,0;0,1,0;0,0,1];
lines = zeros([3,2]);
normals = zeros([3,3]);
for i =1:3
scatter(points(1 ,:,i) ,points(2 ,:,i), 'filled', 'MarkerEdgeColor', colors(i,:),'MarkerFaceColor','w')    
l = polyfit(points(1 ,:,i), points(2 ,:,i), 1);
normals(i,:) = null(points(:,:,i)')';
lines(i,:) = l;
% rital(null(points(:,:,i)');
plot(x, l(1)*x + ones(size(x))*l(2), 'Color', colors(i,:), 'LineWidth', 1);
end
% The intersection between l2 and l3:
intersect23 = cross(normals(2,:),normals(3,:));
intersect23 = intersect23./intersect23(3);
scatter(intersect23(1),intersect23(2), 'MarkerEdgeColor', [1,1,0])
% The distance from intersect23 to the first line:
l1 = normals(1,:);
dist = abs(l1*intersect23')/sqrt(sum(l1(1:2).^2));
%%
H=[1,1,0;0,1,0;-1,0,1];
x1=[1;0;1];
x2 = [0;1;1];
y1 = H*x1;
y2 = H*x2;
l1=cross(x1,x2);
l2=cross(y1,y2);
inverse = inv(H);
l_2 = inverse'*l1;
%% ex3
load compEx3.mat
center2 = size(startpoints,2);
figure(3)
plot([startpoints(1,:); endpoints(1 ,:)],[ startpoints(2 ,:); endpoints(2,:)] , 'b-');
H1=[sqrt(3),-1,1;1,sqrt(3),1;0,0,2];
H2=[1,-1,1;1,1,0;0,0,1];
H3=[1,1,0;0,2,0;0,0,1];
H4=[sqrt(3),-1,1;1,sqrt(3),1;0.25,0.5,2];
matrices = cat(3, H1, H2, H3, H4);
start_h = cat(1, startpoints, ones(1,center2));
end_h = cat(1, endpoints, ones(1,center2));
labels = {'Rigid','Similarity','Affine','Projective'};
for i=1:4
   start_new = pflat(matrices(:,:,i)*start_h);
   end_new = pflat(matrices(:,:,i)*end_h);
   subplot(2,2,i)
    plot([start_new(1,:); end_new(1 ,:)],[start_new(2 ,:); end_new(2,:)]);   
    axis equal
    title(labels(i))
end
%% projected points
X1 = [1;2;3;1];
X2 = [1;1;1;1];
X3 = [1;1;-1;1];
P = [1,0,0,0; 0,1,0,0; 0,0,1,1];
x1 = pflat(P*X1);
x2 = pflat(P*X2);
x3 = P*X3;
%% ex4
load compEx4.mat
i1=imread('compEx4im1.JPG');
i2=imread('compEx4im2.JPG');
center1=null(P1);
center1=center1./center1(4);
center2=null(P2);
center2=center2./center2(4);
normal1 = P1(3,1:3);
normal1=normal1./sqrt(sum(normal1.^2));
normal2 = P2(3,1:3);
normal2=normal2./sqrt(sum(normal2.^2));
%%
pu = pflat(U);
pu=pu(1:3,:);
centers = [center1(1:3),center2(1:3)];
figure(4)
scatter3(pu(1,:),pu(2,:),pu(3,:),'.');
hold on
scatter3(centers(1,:),centers(2,:),centers(3,:));
quiver3(center1(1,:),center1(2,:),center1(3,:), normal1(1),normal1(2),normal1(3),5);
quiver3(center2(1,:),center2(2,:),center2(3,:), normal2(1),normal2(2),normal2(3),5);
%%
figure(5)
u1 = pflat(P1*U);
u2 = pflat(P2*U);
subplot(1,2,1)
imagesc(i1');
colormap gray
hold on
scatter(u1(2,:),u1(1,:), '.');
subplot(1,2,2)
imagesc(i2');
colormap gray
hold on
scatter(u2(2,:),u2(1,:), '.');
%% ex5
im5 = imread('compEx5.jpg');
load('compEx5.mat')
colors=[1,0,0;0,1,0;0,0,1;0,0,0];
k_inv = inv(K);
norm_corners = K\corners;
%%
figure(6)
subplot(1,2,1)
imagesc(im5)
colormap(gray)
hold on
plot(corners(1,[1: end 1]), corners(2,[1: end 1]), '*-');
axis equal
xlim([0,size(im5,2)])
ylim([0,size(im5,1)])
subplot(1,2,2)
plot(norm_corners(1,[1: end 1]), norm_corners(2,[1: end 1]), '*-');
axis equal
axis ij
%%
v = pflat(v);
s = -v(1:3)'*norm_corners;
U = pflat([norm_corners;s]); % the 3D points that project to the corners
%%
figure(7);
plot3(U(1,[1: end 1]), U(2,[1: end 1]), U(3,[1: end 1]), '*-');
hold on
scatter3(0,0,0);
quiver3(0,0,0, 0,0,1);
%%
R=[sqrt(3)/2, 0, 0.5; 0, 1, 0; -0.5, 0, sqrt(3)/2];
t = [-sqrt(3);0;1];
P=[R,t];
normal=P(3,1:3);
figure(8);
plot3(U(1,[1: end 1]), U(2,[1: end 1]), U(3,[1: end 1]), '*-');
hold on
scatter3(2,0,0);
quiver3(2,0,0,normal(1),normal(2),normal(3));
scatter3(0,0,0);
quiver3(0,0,0, 0,0,1);
%%
H=R-t*v(1:3)';
transf_corners = pflat(H*norm_corners);
figure(9);
corners_from_P = pflat(P*U); % equals transf_corners!
scatter(corners_from_P(1,:),corners_from_P(2,:), 25, colors, 'filled')
hold on
scatter(transf_corners(1,:),transf_corners(2,:), 25, colors, 'filled')
axis equal
%% 
H_total = K*H/K;
new_corners = pflat(H_total*corners);
tform = maketform ('projective',H_total');
[new_im ,xdata , ydata ] = imtransform (im ,tform ,'size ',size (im ));
figure;
imagesc(xdata, ydata, new_im)
colormap(gray)
hold on
scatter(new_corners(1,:),new_corners(2,:), 25, colors, 'filled')
axis ij
axis equal
xlim([0,size(new_im,2)])