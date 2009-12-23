function mm_matlab()

%the purpose of this function is to serve as a wrapper for GUI and
%micromanager interface through matlab. Camera control is managed through
%Matlab, everything else is controled through micromanager device adapters

%initialize the interface:
import mmcorej.*;
mmc=CMMCore;
[configfile path]=uigetfile('*.cfg','Select Configuration File','C:\');
mmc.loadSystemConfiguration(strcat(path,configfile));

%convert the relevant config information to MATLAB readable strings:
%CameraMode=mmc.getAvailableConfigs('CameraMode');
Channel=mmc.getAvailableConfigs('Channel');
EMGain=mmc.getAvailableConfigs('EMGain');
Objectives=mmc.getAvailableConfigs('Objectives');
 
% for i=1:CameraMode.size()
%     CameraModetxt{i}=char(CameraMode.get(i-1));
% end
for i=1:Channel.size()
    Channeltxt{i}=char(Channel.get(i-1));
end
% for i=1:EMGain.size()
%     EMGaintxt{i}=char(EMGain.get(i-1));
% end
for i=1:Objectives.size()
    Objectivestxt{i}=char(Objectives.get(i-1));
end
if exist('Objectivestxt','var')==0
    Objectivestxt='';
end
if exist('Channeltxt','var')==0
    Channeltxt='';
end
AllConfig=struct('Channel',{Channeltxt},'Objectives',{Objectivestxt});


%Launch GUI:
mm_startupgui(mmc,AllConfig);