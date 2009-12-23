function mm_gotoLocation(mmc,xyVector)

% This function will tell the stage to go to the point described by
% xyVector = [x y]. It should eventually include a z-offset, though this
% might not be necessary for now.



stage=mmc.getXYStageDevice();

mmc.setXPosition(stage,xyVector(1));
mmc.setYPosition(stage,xyVector(2));
