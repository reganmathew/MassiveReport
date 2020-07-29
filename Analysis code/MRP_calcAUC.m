clear all; close all; clc;

MRP_getROCvalues
g=figure; hold on
set(gca,'FontSize',16)
subplot(2,2,1)
set(gcf, 'color', [1 1 1])
set(gca, 'LineWidth', 1.5)
axis square


plot(im1_20q(:,1),im1_20q(:,2), 'o-'); hold on
plot(im2_20q(:,1),im2_20q(:,2), 'o-'); hold on
plot(im3_20q(:,1),im3_20q(:,2), 'o-'); hold on
plot(im4_20q(:,1),im4_20q(:,2), 'o-'); hold on
plot(im5_20q(:,1),im5_20q(:,2), 'o-'); hold on
ylabel('True positive rate')
title('20Q Fixed')

subplot(2,2,2)
axis square
plot(im1_40q(:,1),im1_40q(:,2), 'o-'); hold on
plot(im2_40q(:,1),im2_40q(:,2), 'o-'); hold on
plot(im3_40q(:,1),im3_40q(:,2), 'o-'); hold on
plot(im4_40q(:,1),im4_40q(:,2), 'o-'); hold on
plot(im5_40q(:,1),im5_40q(:,2), 'o-'); hold on
title('40Q Fixed')

subplot(2,2,3)
axis square
plot(im1_f80q(:,1),im1_f80q(:,2), 'o-'); hold on
plot(im2_f80q(:,1),im2_f80q(:,2), 'o-'); hold on
plot(im3_f80q(:,1),im3_f80q(:,2), 'o-'); hold on
plot(im4_f80q(:,1),im4_f80q(:,2), 'o-'); hold on
plot(im5_f80q(:,1),im5_f80q(:,2), 'o-'); hold on
ylabel('True positive rate')
xlabel('False positive rate')
title('80Q Fixed')

subplot(2,2,4)
axis square
plot(im1_v80q(:,1),im1_v80q(:,2), 'o-'); hold on
plot(im2_v80q(:,1),im2_v80q(:,2), 'o-'); hold on
plot(im3_v80q(:,1),im3_v80q(:,2), 'o-'); hold on
plot(im4_v80q(:,1),im4_v80q(:,2), 'o-'); hold on
plot(im5_v80q(:,1),im5_v80q(:,2), 'o-'); hold on
xlabel('False positive rate')
title('80Q Varied')

lgd = legend('img1','img2','img3','img4','img5');
lgd.Location = 'east'




