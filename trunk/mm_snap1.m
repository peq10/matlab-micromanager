function mm_snap1(mmc,source,topdir,imsubdir,imagecount,chans,exTimes)

%This is the basic algorithm to snap an image in micromanager from Matlab.
%Each call will produce one image per channel for a given field with
%accompanying metadata for the RGB stack.
% Variables:
%   topdir: a string that contains the top or subdirectories specified by the user
%   imsubdir: a string containing identifiers for a particular set of
%              images, be it well number, conditions, etc.
%   chans: a logical vector with 1s marking the desired channels for each
%           stack
%   exTimes: a row vector containing the exposure times for each channel

%Get Channel Names
chNames=mmc.getAvailableConfigs('Channel');
src=getselectedsource(source);

%Set Autoshutter to on (not sure this should be here).
mmc.setAutoShutter(1);

n=find(chans);
m=find(exTimes);

for k=1:sum(chans)
    mmc.setConfig('Channel',chNames.get(n(k)-1));
    set(src,'ExposureTime',exTimes(m(k)));
    imgout=getsnapshot(source);
%     img1=mmc.getImage();
%     imH=mmc.getImageHeight();
%     imW=mmc.getImageWidth();
%     imgout=uint16(reshape(img1,imH,imW));
    if autosave==1
        if exist(strcat(topdir,imsubdir),'dir')==0
            mkdir(topdir,imsubdir);
        end
    imwrite(imgout,strcat(topdir,imsubdir,'img_000000000_',char(chNames.get(n(k)-1)),'_',num2str(imagecount,'%03.0f'),'.tif'),'tif');
    else
        image(imageout)
    end
end