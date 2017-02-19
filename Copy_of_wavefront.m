close all;
image = im;
image = im2double(image);
factor = 13;
m = size(im,1);
n = size(im,2);
startx = (48-42)*factor+1; %substitute in (48-y) * factor + 1
starty = 6*factor+1; %substitute in x * factor + 1
endx = (48-42)*factor+1; % substitute in (48-y) * factor + 1
endy = 90*factor+1; % substitute in x * factor + 1

if(image(startx,starty) == 1)
    disp('bad start pt');
    pause();
end

if(image(endx,endy) == 1)
    disp('bad end pt');
    pause();
end

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
% figure
% imshow(image ./ counter)
arr = zeros(1000,2);
arr(1,:) = [startx, starty];
counter = 2;
current = arr(1,:);
defaultdir = 1;
path = cat(3,im.*255,im.*255,im.*255);
output = zeros(1,1000);
straightlen = 0;
commandcounter = 1;
while ~(current(1,1) == endx && current(1,2) == endy)
    x = current(1,1);
    y = current(1,2);
    b = zeros(1,4);
    b(1,1) = x < m && image(x+1, y) ~= 1 && image(x+1,y) ~= 0 && image(x+1,y) < image(x,y);
    b(1,2) = x > 1 && image(x-1, y) ~= 1 && image(x-1,y) ~= 0 && image(x-1,y) < image(x,y);
    b(1,3) = y < n && image(x, y+1) ~= 1 && image(x,y+1) ~= 0 && image(x,y+1) < image(x,y);
    b(1,4) = y > 1 && image(x, y-1) ~= 1 && image(x,y-1) ~= 0 &&image(x,y-1) < image(x,y);
    b(1,5) = x > 1 && y > 1 && image(x-1, y-1) ~= 1 && image(x-1,y-1) < image(x,y);
    b(1,6) = x > 1 && y < n && image(x-1, y+1) ~= 1 && image(x-1,y+1) < image(x,y);
    b(1,7) = x < m && y > 1 && image(x+1, y-1) ~= 1 && image(x+1,y-1) < image(x,y);
    b(1,8) = x<m && y< n && image(x+1, y+1) ~= 1 && image(x+1,y+1) < image(x,y);
    pts = zeros(4,2);
    pts(1,:) = [x+1, y];
    pts(2,:) = [x-1, y];
    pts(3,:) = [x,y+1];
    pts(4,:) = [x,y-1];
    pts(5,:) = [x-1,y-1];
    pts(6,:) = [x-1,y+1];
    pts(7,:) = [x+1,y-1];
    pts(8,:) = [x+1,y+1];
    angles = [0 180 90 270 225 135 315 45];
    if(defaultdir < 5 && b(1,defaultdir))
        straightlen = straightlen + 1 / factor;
        arr(counter,:) = pts(defaultdir,:);
        current = arr(counter,:);
        counter = counter + 1;
        path(pts(defaultdir,1),pts(defaultdir,2),1) = 255;
        continue;
    end
    for i = 1 : 4
        if(b(1,i))
            output(:,commandcounter) = straightlen;
            straightlen = 0;
            th = - angles(1,defaultdir) + angles(1,i);
            if(th < -180)
                th = th + 360;
            end
            if(th > 180)
                th = th - 360;
            end
            output(:,commandcounter+1) = th;
            commandcounter = commandcounter + 2;
            arr(counter,:) = pts(i,:);
            current = arr(counter,:);
            counter = counter + 1;
            path(pts(i,1),pts(i,2),1) = 255;
            defaultdir = i;
            break;
        end
    end
    if(b(1,defaultdir))
        straightlen = straightlen + 1 / factor;
        arr(counter,:) = pts(defaultdir,:);
        current = arr(counter,:);
        counter = counter + 1;
        path(pts(defaultdir,1),pts(defaultdir,2),1) = 255;
        continue;
    end
    for i = 5 : 8
        if(b(1,i))
            output(:,commandcounter) = straightlen;
            straightlen = 0;
            th = - angles(1,defaultdir) + angles(1,i);
            if(th < -180)
                th = th + 360;
            end
            if(th > 180)
                th = th - 360;
            end
            output(:,commandcounter+1) = th;
            commandcounter = commandcounter + 2;
            arr(counter,:) = pts(i,:);
            current = arr(counter,:);
            counter = counter + 1;
            path(pts(i,1),pts(i,2),1) = 255;
            defaultdir = i;
            break;
        end
    end
end
output(:,commandcounter) = straightlen;
fileID = fopen('output.txt','w');
output = output(:,1:commandcounter);
fprintf(fileID, 'int num = %d;\n',size(output,2)+1);
fprintf(fileID, 'int input[%d] = {',size(output,2)+1);
for i = 1 : size(output,2)
    if i == size(output,2)
        fprintf(fileID, '%.3f};', output(1,i));
    else
        fprintf(fileID, '%.3f,', output(1,i));
    end
end

figure
imshow(path)