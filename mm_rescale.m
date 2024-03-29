function imgout=mm_rescale(img_in)

% this rescales images from microscopes

% 
% [imlist, path]=uigetfile('*.tif','Select files to rescale','MultiSelect','on');
% 
% if iscell(imlist)==0
%     imlist={imlist};
% end

% [rows, imgs]=size(imlist);
% mkdir(path,'rescaled');
% for i=1:imgs
%    img_in=imread(strcat(path,imlist{i}));
%    imgmin=min(img_in(:));
    imgmax=max(img_in(:));
    
    %rescale linearly over min and max
    imgout=(img_in/imgmax)*(65535/imgmax);
 %   imwrite(uint16(img_out),strcat(path,'rescaled\',imlist{i}),'tif');

    