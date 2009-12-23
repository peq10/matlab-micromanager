function mm_simplesnap(mmc,snapInfo,vid)

%This is the basic algorithm to snap an image in micromanager from Matlab.
%Each call will take the image and load it into the workspace (imshow).
% Variables:
%   snapInfo:: is a structure that comes in from the gui to snap an image and
%               load it into the workspace
%   mmc:: is the java class for calling the microscope.
%   AllConfig:: is a structure that contains all the text information about
%               about the microscope (channel names, objectives, camera
%               modes, etc.)

%Check if preview is running to try not to screw it up:
if snapInfo.vid==1
    stopreview(snapInfo.vid)
    restartpreview=1;
end
%load source to change properties (extime, EMCCD, etc.)
src=getselectedsource(vid);

%Set Channel, extime, and snap the image
mmc.setConfig('Channel',snapInfo.Channel);
set(src,'ExposureTime',snapInfo.extime/1000);
imgout=getsnapshot(vid);
figure
imshow(imgout,[min(imgout(:)) max(imgout(:))]);

if restartpreview==1
    keyboard
    preview(vid)
end