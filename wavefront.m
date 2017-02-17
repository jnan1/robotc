image = im;
image = im2double(image);
factor = 13;
m = 630;
n = 1260;
startx = 69;
starty = 545;
endx = 83;
endy = 719;

counter = 2;
image(endx, endy) = 2;
while (image(startx, starty) == 0)
    [x,y] = find(image == counter);
    counter = counter + 1;
    for i = 1 : size(x,1)
        if(x(i)>1 && image(x(i)-1,y(i)) == 0)
            image(x(i)-1, y(i)) = counter;
        end
        if(x(i)<m && image(x(i)+1, y(i)) == 0)
            image(x(i)+1, y(i)) = counter;
        end
        if(y(i)>1 && image(x(i), y(i)-1) == 0)
            image(x(i), y(i)-1) = counter;
        end
        if(y(i)<n && image(x(i), y(i)+1) == 0)
            image(x(i), y(i)+1) = counter;
        end
        if(x(i)>1 && y(i) > 1 && image(x(i)-1,y(i)-1) == 0)
            image(x(i)-1,y(i)-1) = counter;
        end
        if(x(i)>1 && y(i) < n && image(x(i)-1, y(i)+1) == 0)
            image(x(i)-1,y(i)+1) = counter;
        end
        if(x(i)<m && y(i) > 1 && image(x(i)+1, y(i)-1) == 0)
            image(x(i)+1, y(i)-1) = counter;
        end
        if(x(i)<m && y(i) < n && image(x(i)+1, y(i)+1) == 0)
            image(x(i)+1, y(i)+1) = counter;
        end
    end
end
figure
imshow(image ./ counter)

arr = zeros(1000,2);
arr(1,:) = [startx, starty];
counter = 2;
current = arr(1,:);
defaultdir = 1;
path = cat(3,im.*255,im.*255,im.*255);
while ~(current(1,1) == endx && current(1,2) == endy)
    x = current(1,1);
    y = current(1,2);
    b = zeros(1,8);
    b(1,1) = x < m && image(x+1, y) ~= 1 && image(x+1,y) < image(x,y);
    b(1,2) = x > 1 && image(x-1, y) ~= 1 && image(x-1,y) < image(x,y);
    b(1,3) = y < n && image(x, y+1) ~= 1 && image(x,y+1) < image(x,y);
    b(1,4) = y > 1 && image(x, y-1) ~= 1 && image(x,y-1) < image(x,y);
    b(1,5) = x > 1 && y > 1 && image(x-1, y-1) ~= 1 && image(x-1,y-1) < image(x,y);
    b(1,6) = x > 1 && y < n && image(x-1, y+1) ~= 1 && image(x-1,y+1) < image(x,y);
    b(1,7) = x < m && y > 1 && image(x+1, y-1) ~= 1 && image(x+1,y-1) < image(x,y);
    b(1,8) = x<m && y< n && image(x+1, y+1) ~= 1 && image(x+1,y+1) < image(x,y);
    pts = zeros(8,2);
    pts(1,:) = [x+1, y];
    pts(2,:) = [x-1, y];
    pts(3,:) = [x,y+1];
    pts(4,:) = [x,y-1];
    pts(5,:) = [x-1,y-1];
    pts(6,:) = [x-1,y+1];
    pts(7,:) = [x+1,y-1];
    pts(8,:) = [x+1,y+1];
    if(b(1,defaultdir))
        arr(counter,:) = pts(defaultdir,:);
        current = arr(counter,:);
        counter = counter + 1;
        path(pts(defaultdir,1),pts(defaultdir,2),1) = 255;
        continue;
    end
    for i = 1 : 8
        if(b(1,i))
            arr(counter,:) = pts(i,:);
            current = arr(counter,:);
            counter = counter + 1;
            path(pts(i,1),pts(i,2),1) = 255;
            defaultdir = i;
            break;
        end
    end
end

% size(path)
% % max(arr(:,2))
% path(arr(1:counter-1,:),1) = 255;
figure
imshow(path)

