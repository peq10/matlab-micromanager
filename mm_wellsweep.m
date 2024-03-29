function mm_wellsweep(mmc,welltype,imageinfo)

%this function will step around the well from the center covering the
%entire area of the well with images. 
% Variables:  
%  welltype = a numerical value telling the program the configuration of
%               wells. Values are 6, 12, 24 and 96.
%  imageinfo = a structure with the appropriate image acquisition
%               parameters
%
% Uses relative positioning to avoid rezeroing, but setOriginXY(stage) can
% do the trick.

chans=imageinfo.chans;
topdir=imageinfo.topdir;
imsubdir=imageinfo.imsubdir;
exTimes=imageinfo.extimes;

%set correct diameter in um
if welltype == 6
    diameter=35000;
    betweenwell=4500;
    wellshigh=2;
    %wellswide=3;
    %wellcenters={[0,0],[0,39500],[39500,0],[39500,39500],[79000,0],[79000,39500]};
elseif welltype == 12
    diameter=22090;
    betweenwell=4150;
    wellshigh=3;
    %wellswide=4;
    %wellcenters={[0,0]};
elseif welltype == 24
    diameter=15490;
    betweenwell=4200;
    wellshigh=4;
    %wellswide=6;
    %wellcenters={[0,0]};
elseif welltype == 96
    diameter=6350;
    betweenwell=3300;
    wellshigh=8;
    %wellswide=12;
    %wellcenters={[0,0]};
end

if imageinfo.fiduciary==1
    mm_findfiduc(mmc,welltype)
end

%calculate total images needed to cover well area (Currently assumes for
%square images)
pixelsize=mmc.getPixelSizeUm();
imagestep=pixelsize*mmc.getImageHeight();
maxlength=ceil((diameter/sqrt(2))/imagestep);
stage=mmc.getXYStageDevice();
% mmc.setOriginXY(stage); <- will be set from mm_findfiduc

well=1;
col=0;
for m=1:welltype
    imagecount=0;
    %After the first time through, goto the correct well:
    if well>=2
        row=mod(well,wellshigh);
        if row==0
            row=wellshigh;
            nextcol=1;
        end
        tStart=tic;
        mmc.setXPosition(stage,(col)*diameter+(col)*betweenwell)
        mmc.setYPosition(stage,(row-1)*diameter+(row-1)*betweenwell)
        if nextcol==1
            col=col+1;
            nextcol=0;
        end
    end
    %probably need to have a few second wait here
    while toc(tStart) <= 3
        continue    
    end
    for i=1:maxlength
        if mod(i,2)==1
            yfactor=1;
            xfactor=-1;
        elseif mod(i,2)==0
            yfactor=-1;
            xfactor=1;
        end
        %Snap first Image
        mm_snap1(mmc,imageinfo.source,topdir,imsubdir,imagecount,chans,exTimes);
        imagecount=imagecount+1;
        for j=1:i
            y=yfactor*imagestep;
            mmc.setRelativeXYPosition(stage,0,y);
    % Taken out because I don't think I'll ever actually need to slow down the
    % script.
    %         tStart=tic;
    %         while toc(tStart) < 0.5
    %             continue
    %         end
            mm_snap1(mmc,imageinfo.source,topdir,imsubdir,imagecount,chans,exTimes);
    %         xy(imagecount)={[mmc.getXPosition(stage) mmc.getYPosition(stage)]};
            imagecount=imagecount+1;
        end
        for k=1:i
            x=xfactor*imagestep;
            mmc.setRelativeXYPosition(stage,x,0);
    %         tStart=tic; (Slowdown)
    %         while toc(tStart) < 0.5
    %             continue
    %         end
            mm_snap1(mmc,imageinfo.source,topdir,imsubdir,imagecount,chans,exTimes);
    %         xy(imagecount)={[mmc.getXPosition(stage) mmc.getYPosition(stage)]};
            imagecount=imagecount+1;
        end
    end % Loop within each well
    well=well+1;
    imsubdir=strcat('\Well_',num2str(well,'%02.0f'),'\');
end % Loop for all wells