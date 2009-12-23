function varargout = mm_preview(varargin)
% MM_PREVIEW M-file for mm_preview.fig
%      MM_PREVIEW, by itself, creates a new MM_PREVIEW or raises the existing
%      singleton*.
%
%      H = MM_PREVIEW returns the handle to a new MM_PREVIEW or the handle to
%      the existing singleton*.
%
%      MM_PREVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MM_PREVIEW.M with the given input arguments.
%
%      MM_PREVIEW('Property','Value',...) creates a new MM_PREVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mm_preview_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mm_preview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mm_preview

% Last Modified by GUIDE v2.5 16-Dec-2009 17:58:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mm_preview_OpeningFcn, ...
                   'gui_OutputFcn',  @mm_preview_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mm_preview is made visible.
function mm_preview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mm_preview (see VARARGIN)

% Choose default command line output for mm_preview
handles.output = hObject;
handles.mmc=varargin{1};
handles.extime=varargin{2};
handles.vid=varargin{3};
handles.AllConfig=varargin{4};
handles.previewstart=0;
handles.src=getselectedsource(handles.vid);
% handles.mmc.loadSystemConfiguration(strcat(varargin{4},varargin{5}))
if handles.previewstart==0
    keyboard
    handles.image=image(zeros(512,512),'Parent',handles.preview_axes1);
    handles.mmc.setShutterOpen(1)
    set(handles.src,'ExposureTime',handles.extime/1000)
    handles.mmc.setConfig('Channel',handles.AllConfig.Channel(get(findobj('Tag','Channel_menu'),'String')))
    preview(handles.vid,handles.image);
    handles.previewstart=1;
end
% handles.mmc.setShutterOpen(1)
% handles.mmc.setConfig('Channel','DIC')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mm_preview wait for user response (see UIRESUME)
% uiwait(handles.Preview_fig);


% --- Outputs from this function are returned to the command line.
function varargout = mm_preview_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles.stop=0;
% if handles.mmc.isSequenceRunning==0
%      handles.mmc.startContinuousSequenceAcquisition(double(handles.extime))
% end
% handles.tic=tic;
% handles.mmc.setAutoShutter(1);
% handles.mmc.setConfig('Channel','DIC')
% while handles.mmc.imagesRemaining()>0
%     img1=handles.mmc.popNextImage;
%     img2=reshape(img1,handles.mmc.getImageWidth(),handles.mmc.getImageHeight());
%     img3=mm_rescale(img2);
%     axes(handles.preview_axes1);
%     image(img3)
%     axis off
% end
% handles.stop=1;

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Stop_pushbutton.
function Stop_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.previewstart==1    %check if the preview is running
    stoppreview(handles.vid)    %If it is running, stop it and change button text
    set(hObject,'String','Start Preview')
    handles.previewstate=0;
elseif handles.previewstart==0    %if it's not running, start it
    handles.image=image(zeros(512,512),'Parent',handles.preview_axes1);
    preview(handles.vid,handles.image);            % and change button text
    set(hObject,'String','Stop Preview')
    handles.previewstate=1;
end
handles.previewstart=handles.previewstate;
guidata(hObject,handles)


% --- Executes on button press in Snap_pushbutton.
function Snap_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Snap_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%need to have a new GUI pop out for saving images
handles.image=getsnapshot(handles.vid);
figure 
imshow(handles.image,[min(handles.image(:)) max(handles.image(:))]);


% --- Executes on button press in Close_pushbutton.
function Close_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Close_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closepreview(handles.vid)
close(handles.Preview_fig)
