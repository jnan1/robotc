img = imread('map.png');
img = im2bw(img, 0);
img = img(4:size(img,1)-1, :);
img(:,2:3) = 0;
img(size(img,1),:) = 1;
img(1,:) = 1;
img(:,size(img,2)) = 1;
figure
imshow(img)
robotwidth = 7;
robotradius = robotwidth / 2;
size(img)
factor = size(img,1)/(4*12);
im = img;
for i = 1:size(img, 1)
    for j = 1:size(img,2)
       radius = ceil(robotradius * factor);
       x1 = i-radius;
       x2 = i+radius;
       y1 = j-radius;
       y2 = j+radius;
       if(x1<1)
           x1 = 1;
       elseif(x2>size(img,1))
           x2 = size(img,1);
       end
       if(y1<1)
           y1 = 1;
       elseif(y2>size(img,2))
           y2 = size(img,2);
       end
       if(img(i,j) == 1)
           im(x1:x2,y1:y2) = ones(x2-x1+1,y2-y1+1);
       end
    end
end
imshow(im);