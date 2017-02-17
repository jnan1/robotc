res = 4;
map = zeros(4 * 12 * res, 8*12*res);
map(36*res : 38*res, 12*res : 36*res) = 1;
map(26*res : 48*res, 47*res : 49*res) = 1;
map(24*res : 26*res, 38*res : 58*res) = 1;
map(28.5*res : 48*res, 66*res : 82.75*res) = 1;
map(12*res:20*res, 60*res : 73.25*res) = 1;
map(13.5*res : 24*res, 12*res:25*res) = 1;
figure
imshow(map)