% 参考http://blog.csdn.net/dengxf01/article/details/53374014
% 参考http://blog.csdn.net/wd1603926823/article/details/45672741
% 张伟等 《鱼眼图像校正算法研究》
function [img_valid, R] = imageEffectiveAreaInterception(img, T)
% input
% img: rgb image
% T: gray threshold
% output
% img_valid: effective image area
% R: effective image area radius

% rgb to gray
% gray = 0.299r + 0.587g + 0.114b
img_gray = rgb2gray(img);

% image size
[m, n, k] = size(img_gray);

% scan from top to bottom
for i = 1:m
    flag = 0;
    for j = 1:n
        if(img_gray(i, j) >= T)
           if(img_gray(i+1, j) >= T)
               top = i;
               flag = 1;
               break;
           end
        end
    end
    if flag == 1; break; end
end

% scan from bottom to top
for i = m:-1:top
    flag = 0;
    for j = 1:n
        if(img_gray(i, j) >= T)
           if(img_gray(i-1, j) >= T)
               bottom = i;
               flag = 1;
               break;
           end
        end
    end
    if flag == 1; break; end
end

% scan from left to right
for j = 1:n
    flag=0;    
    for i = top:bottom
        if(img_gray(i, j) >= T)
           if(img_gray(i, j+1) >= T)
               left = j;
               flag = 1;               
               break;
           end
        end
    end
    if flag == 1; break; end
end

% scan from right to left
for j = n:-1:left
    flag = 0;    
    for i = top:bottom
        if(img_gray(i, j) >= T)
           if(img_gray(i, j-1) >= T)
               right = j;
               flag = 1;               
               break;
           end
        end
    end
    if flag == 1; break; end
end

% effictive area radius
R = max((right - left)/2, (bottom - top)/2);

% create effictive area 
img_valid = imcrop(img, [left, top, 2*R, 2*R]);
end
