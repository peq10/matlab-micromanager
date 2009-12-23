function mm_multiTime(mmc,source,topdir,imsubdir,chans,exTimes,xylist,timesettings)

%This is the basic algorithm to snapimages in Matlab using a multipoint
%acquisition pattern. Each position will get its own subfolder and channels 
%and images will be named and counted accordingly.
% Variables:
%   topdir: a string that contains the top or subdirectories specified by the user
%   imsubdir: a string containing identifiers for a particular set of
%              images, be it well number, conditions, etc.
%   chans: a logical vector with 1s marking the desired channels for each
%           stack
%   exTimes: a row vector containing the exposure times for each channel
%   xylist: the list of positions in the xy plane to be used.
%   timesettings: a structure with the timestep (.step) and total time 
%                   (.total) of the timecourse.

%get some information about the hardware and acquisition:
chNames=mmc.getAvailableConfigs('Channel');
stage=mmc.getXYStageDevice();
n=find(chans);
m=find(exTimes);
src=getselectedsource(source);
imagecount=0;
totalimages=ceil(timesettings.total/timesettings.step);

%get number of positions:
[x cols]=size(xylist);
positions=1;

while imagecount<=totalimages

    while positions<cols
        mmc.setXPosition(stage,double(xylist{positions}(1)))
        mmc.setYPosition(stage,double(xylist{positions}(2)))
        %wait until at position
        tStart=tic;
        %can maybe chance to XYBusy command?
        while mmc.getXYPosition(stage) ~= xylist{positions}
            if toc(tStart) <15
                continue
            elseif toc(tStart)>15
            end
        end
        for k=1:sum(chans)
            mmc.setConfig('Channel',chNames.get(n(k)-1));
            set(src,'ExposureTime',exTimes(m(k)));
            timepoint=tic;
            imgout=getsnapshot(source);
        %     img1=mmc.getImage();
        %     imH=mmc.getImageHeight();
        %     imW=mmc.getImageWidth();
        %     imgout=uint16(reshape(img1,imH,imW));
        %    if autosave==1
            possubdir=strcat(imsubdir,filesep,'Pos_',num2str(positions));
            if exist(strcat(topdir,possubdir),'dir')==0
                mkdir(topdir,possubdir);
            end
            imwrite(imgout,strcat(topdir,possubdir,'img_000000000_',char(chNames.get(n(k)-1)),'_',num2str(imagecount,'%03.0f'),'.tif'),'tif','Compression','none','RowsPerStrip','512');
        %    end
        end
        positions=positions+1;
    end
    positions=1;
    mmc.setXPosition(stage,double(xylist{positions}(1)))
    mmc.setYPosition(stage,double(xylist{positions}(2)))
    while toc(timepoint)<timesettings.step
        continue
    end
    imagecount=imagecount+1;
end