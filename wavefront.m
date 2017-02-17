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
    if(x < m && image(x+1, y) ~= 1 && image(x+1,y) < image(x,y))
        arr(counter, :) = [x+1,y];
        path(x+1, y, 1) = 255;
    elseif(x > 1 && image(x-1, y) ~= 1 && image(x-1,y) < image(x,y))
        arr(counter,:) = [x-1,y];
        path(x-1, y, 1) = 255;
    elseif(y < n && image(x, y+1) ~= 1 && image(x,y+1) < image(x,y))
        arr(counter,:) = [x,y+1];
        path(x, y+1, 1) = 255;
    elseif(y > 1 && image(x, y-1) ~= 1 && image(x,y-1) < image(x,y))
        arr(counter,:) = [x,y-1];
        path(x, y-1, 1) = 255;
    elseif(x >1 && y > 1 && image(x-1, y-1) ~= 1 && image(x-1,y-1) < image(x,y))
        arr(counter,:) = [x-1,y-1];
        path(x-1, y-1, 1) = 255;
    elseif(x >1 && y < n && image(x-1, y+1) ~= 1 && image(x-1,y+1) < image(x,y))
        arr(counter,:) = [x-1,y+1];
        path(x-1, y+1, 1) = 255;
    elseif(x<m && y > 1 && image(x+1, y-1) ~= 1 && image(x+1,y-1) < image(x,y))
        arr(counter,:) = [x+1,y-1];
        path(x+1, y-1, 1) = 255;
    elseif(x<m && y< n && image(x+1, y+1) ~= 1 && image(x+1,y+1) < image(x,y))
        arr(counter,:) = [x+1,y+1];
        path(x+1, y+1, 1) = 255;
    end
    current = arr(counter,:);
    counter = counter + 1;
end

% size(path)
% % max(arr(:,2))
% path(arr(1:counter-1,:),1) = 255;
figure
imshow(path)

