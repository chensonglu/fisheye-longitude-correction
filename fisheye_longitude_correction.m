% 参考http://blog.csdn.net/wd1603926823/article/details/45841841
% 张伟等 《鱼眼图像校正算法研究》
% 黄有度等 《一种鱼眼图象到透视投影图象的变换模型》
% 汪丹等 《一种不断重定位圆心的鱼眼图像校正方法》
% for循环矩阵化 http://blog.csdn.net/myj0513/article/details/6871482
% 两个向量分别保存行列坐标，提取相应元素 http://www.ilovematlab.cn/thread-63242-1-1.html
function result = fisheye_longitude_correction(img, T)
% input
% image: rgb image
% T: gray threshold
% output
% result: corrected image

tic; % record run time
[img_valid, R] = imageEffectiveAreaInterception(img, T); % effective image area 
[m, n, k] = size(img_valid);
result = zeros(m, n, 3); % preallocation
x0 = n/2; y0 = m/2; % image center

% core code
[v, u] = meshgrid(1:m, 1:n);
tmp = round(sqrt(abs(R^2-(u-y0).^2)).*(v-x0)/R+x0);

% reshape
for i = 1:k
   img_gray = img_valid(:, :, i);
   coordinate = u(:) + (tmp(:) - 1)*m;
   channel = img_gray(coordinate);
   channel_reshape = reshape(channel, m, n);
   result(:, :, i) = channel_reshape;
end

% transform
result=uint8(result);
toc;
end
