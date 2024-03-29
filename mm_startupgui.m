function varargout = mm_startupgui(varargin)
% MM_STARTUPGUI M-file for mm_startupgui.fig
%      MM_STARTUPGUI, by itself, creates a new MM_STARTUPGUI or raises the existing
%      singleton*.
%
%      H = MM_STARTUPGUI returns the handle to a new MM_STARTUPGUI or the handle to
%      the existing singleton*.
%
%      MM_STARTUPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MM_STARTUPGUI.M with the given input arguments.
%
%      MM_STARTUPGUI('Property','Value',...) creates a new MM_STARTUPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mm_startupgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mm_startupgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mm_startupgui

% Last Modified by GUIDE v2.5 16-Dec-2009 17:58:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mm_startupgui_OpeningFcn, ...
                   'gui_OutputFcn',  @mm_startupgui_OutputFcn, ...
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


% --- Executes just before mm_startupgui is made visible.
function mm_startupgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mm_startupgui (see VARARGIN)

% Choose default command line output for mm_startupgui
handles.output = hObject;
handles.mmc=varargin{1};
handles.AllConfig=varargin{2};
set(handles.Channel_Menu,'String',handles.AllConfig.Channel);
%set(handles.CameraMode_Menu,'String',handles.AllConfig.CameraMode);
set(handles.Objectives_Menu,'String',handles.AllConfig.Objectives);
handles.vidbin1=videoinput('hamamatsu',1,'MONO16_512x512_FasterMode');
handles.vidbin2=videoinput('hamamatsu',1,'MONO16_Bin2x2_256x256_FasterMode');
handles.vidbin3=videoinput('hamamatsu',1,'MONO16_Bin4x4_128x128_FasterMode');
handles.vid=handles.vidbin1;
handles.previewstart=0;
axes(handles.imhist_axes1);
axis off
%need to update GUI with current machine settings (objective, etc.)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mm_startupgui wait for user response (see UIRESUME)
% uiwait(handles.Startup_fig);


% --- Outputs from this function are returned to the command line.
function varargout = mm_startupgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function exposure_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to exposure_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exposure_edit1 as text
%        str2double(get(hObject,'String')) returns contents of exposure_edit1 as a double
handles.extime=str2double(get(hObject,'String'));
if handles.previewstart==1
    set(handles.src,'ExposureTime',handles.extime/1000)
end
%add if preview is running
%     set(src,'ExposureTime',(handles.extime/1000)
%end
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function exposure_edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exposure_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in binning_popupmenu1.
function binning_popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to binning_popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.restart=0;
%check if the preview is running
if handles.previewstart==1
    stoppreview(handles.vid)
    handles.restart=1;
    handles.previewstart=0;
end
%reset the active video (handles.vid)
binning=get(hObject,'Value');
if binning==1
    handles.vid=handles.vidbin1;
elseif binning==4
    handles.vid=handles.vidbin2;
elseif binning==8
    handles.vid=handles.vidbin3;
end

%restart the preview
if handles.restart==1
    handles.restart=0;
    handles.extime=str2num(get(handles.exposure_edit1,'String'));
    handles.mmc.setConfig('Channel',handles.AllConfig.Channel{get(handles.Channel_Menu,'Value')})
    handles.mmc.setShutterOpen(1)
    mm_preview(handles.mmc,handles.extime,handles.vid,handles.AllConfig)
    handles.previewstart=1;
end

guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function binning_popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to binning_popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CameraMode_Menu.
function CameraMode_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to CameraMode_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This works with mmc: 
% handles.mmc.setConfig('CameraMode',handles.AllConfig.CameraMode{get(hObject,'Value')});
%Need to setup with matlab control

guidata(hObject,handles)
% Hints: contents = get(hObject,'String') returns CameraMode_Menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CameraMode_Menu


% --- Executes during object creation, after setting all properties.
function CameraMode_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CameraMode_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Channel_Menu.
function Channel_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Channel_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%set the new config for the appropriate channel
handles.mmc.setConfig('Channel',handles.AllConfig.Channel{get(hObject,'Value')});
guidata(hObject, handles)


% --- Executes during object creation, after setting all properties.
function Channel_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channel_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Objectives_Menu.
function Objectives_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Objectives_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mmc.setConfig('Objectives',handles.AllConfig.Objectives{get(hObject,'Value')})
guidata(hObject,handles)
% Hints: contents = get(hObject,'String') returns Objectives_Menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Objectives_Menu


% --- Executes during object creation, after setting all properties.
function Objectives_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Objectives_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function EMGain_slider_Callback(hObject, eventdata, handles)
% hObject    handle to EMGain_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.EMGain_edit2,'String',get(hObject,'Value'))
guidata(hObject,handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function EMGain_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EMGain_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function EMGain_edit2_Callback(hObject, eventdata, handles)
% hObject    handle to EMGain_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EMGain_edit2 as text
%        str2double(get(hObject,'String')) returns contents of EMGain_edit2 as a double
set(hObject,'String',get(handles.EMGain_Slider2,'Value'))
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function EMGain_edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EMGain_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in snapimage_pushbutton1.
function snapimage_pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to snapimage_pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%need to collect data for mm_simplesnap
snapInfo.Channel=handles.AllConfig.Channel(get(handles.Channel_Menu,'Value'));
snapInfo.extime=str2num(get(handles.exposure_edit1,'String'));
snapInfo.vid=handles.previewstart;

%call simplesnap to load an image into the workspace.
mm_simplesnap(handles.mmc,snapInfo,handles.vid)
guidata(hObject,handles)

% --- Executes on button press in livePreview_pushbutton2.
function livePreview_pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to livePreview_pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.vidbin1=videoinput('hamamatsu',1,'MONO16_512x512_FasterMode');
handles.vidbin2=videoinput('hamamatsu',1,'MONO16_Bin2x2_256x256_FasterMode');
handles.vidbin3=videoinput('hamamatsu',1,'MONO16_Bin4x4_128x128_FasterMode');
handles.vid=handles.vidbin1;
%Send to the customGUI for previewing
mm_preview(handles.mmc,handles.extime,handles.vid,handles.AllConfig)
guidata(hObject, handles);


% --- Executes on button press in multiDAcq.
function multiDAcq_Callback(hObject, eventdata, handles)
% hObject    handle to multiDAcq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mm_multidacq(handles.mmc,handles.AllConfig,handles)
guidata(hObject,handles)

% --- Executes on button press in autoShutter_checkbox1.
function autoShutter_checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to autoShutter_checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mmc.setAutoShutter(get(hObject,'Value'));
guidata(hObject,handles)
