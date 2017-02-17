image = im2bw(im, 0);
image = im2double(image);
factor = 13;
m = 630;
n = 1260;
startx = 1;
starty = 1;
endx = 620;
endy = 620;

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
    end
end
figure
imshow(image)

arr = zeros(1000,2);
arr(1,:) = [startx, starty];
current = arr(1,:);
while ~(current(1,1) == endx && current(1,2) == endy)
    x = current(1,1);
    y = current(1,2);
    
end
