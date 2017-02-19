load('img.mat');
im2 = cat(3,im.*255,im.*255,im.*255);
im2(:,630,1) = 255;
im2(:,630,2) = 0;
im2(:,630,3) = 0;
figure;
imshow(im2);