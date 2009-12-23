function varargout = mm_multidacq(varargin)
% MM_MULTIDACQ M-file for mm_multidacq.fig
%      MM_MULTIDACQ, by itself, creates a new MM_MULTIDACQ or raises the existing
%      singleton*.
%
%      H = MM_MULTIDACQ returns the handle to a new MM_MULTIDACQ or the handle to
%      the existing singleton*.
%
%      MM_MULTIDACQ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MM_MULTIDACQ.M with the given input arguments.
%
%      MM_MULTIDACQ('Property','Value',...) creates a new MM_MULTIDACQ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mm_multidacq_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mm_multidacq_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mm_multidacq

% Last Modified by GUIDE v2.5 21-Dec-2009 18:55:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mm_multidacq_OpeningFcn, ...
                   'gui_OutputFcn',  @mm_multidacq_OutputFcn, ...
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


% --- Executes just before mm_multidacq is made visible.
function mm_multidacq_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mm_multidacq (see VARARGIN)

% Choose default command line output for mm_multidacq
handles.output = hObject;
handles.mmc=varargin{1};
handles.AllConfig=varargin{2};
set(handles.Outputdir_edit,'String','C:/')
set(handles.Subdir_edit,'String','')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mm_multidacq wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mm_multidacq_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Brightfield_checkbox.
function Brightfield_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Brightfield_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Brightfield_checkbox


% --- Executes on button press in DIC_checkbox.
function DIC_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to DIC_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DIC_checkbox


% --- Executes on button press in DAPI_checkbox.
function DAPI_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to DAPI_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DAPI_checkbox


% --- Executes on button press in GFP_checkbox.
function GFP_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to GFP_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GFP_checkbox


% --- Executes on button press in RFP_checkbox.
function RFP_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to RFP_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RFP_checkbox


% --- Executes on button press in FarRed_checkbox.
function FarRed_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to FarRed_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FarRed_checkbox


% --- Executes on button press in NileRed_checkbox.
function NileRed_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to NileRed_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NileRed_checkbox



function Brightfield_extime_Callback(hObject, eventdata, handles)
% hObject    handle to Brightfield_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Brightfield_extime as text
%        str2double(get(hObject,'String')) returns contents of Brightfield_extime as a double


% --- Executes during object creation, after setting all properties.
function Brightfield_extime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Brightfield_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DIC_extime_Callback(hObject, eventdata, handles)
% hObject    handle to DIC_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DIC_extime as text
%        str2double(get(hObject,'String')) returns contents of DIC_extime as a double


% --- Executes during object creation, after setting all properties.
function DIC_extime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DIC_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DAPI_extime_Callback(hObject, eventdata, handles)
% hObject    handle to DAPI_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DAPI_extime as text
%        str2double(get(hObject,'String')) returns contents of DAPI_extime as a double


% --- Executes during object creation, after setting all properties.
function DAPI_extime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DAPI_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GFP_extime_Callback(hObject, eventdata, handles)
% hObject    handle to GFP_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GFP_extime as text
%        str2double(get(hObject,'String')) returns contents of GFP_extime as a double


% --- Executes during object creation, after setting all properties.
function GFP_extime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GFP_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RFP_extime_Callback(hObject, eventdata, handles)
% hObject    handle to RFP_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RFP_extime as text
%        str2double(get(hObject,'String')) returns contents of RFP_extime as a double


% --- Executes during object creation, after setting all properties.
function RFP_extime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFP_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FarRed_extime_Callback(hObject, eventdata, handles)
% hObject    handle to FarRed_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FarRed_extime as text
%        str2double(get(hObject,'String')) returns contents of FarRed_extime as a double


% --- Executes during object creation, after setting all properties.
function FarRed_extime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FarRed_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NileRed_extime_Callback(hObject, eventdata, handles)
% hObject    handle to NileRed_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NileRed_extime as text
%        str2double(get(hObject,'String')) returns contents of NileRed_extime as a double


% --- Executes during object creation, after setting all properties.
function NileRed_extime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NileRed_extime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Wellsweep_checkbox.
function Wellsweep_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Wellsweep_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Wellsweep_checkbox


% --- Executes on button press in Timecourse_checkbox.
function Timecourse_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Timecourse_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Timecourse_checkbox


% --- Executes on button press in Zstack_checkbox.
function Zstack_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Zstack_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Zstack_checkbox



function Outputdir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Outputdir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Outputdir_edit as text
%        str2double(get(hObject,'String')) returns contents of Outputdir_edit as a double


% --- Executes during object creation, after setting all properties.
function Outputdir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Outputdir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Subdir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Subdir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Subdir_edit as text
%        str2double(get(hObject,'String')) returns contents of Subdir_edit as a double


% --- Executes during object creation, after setting all properties.
function Subdir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Subdir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Acquire_pushbutton.
function Acquire_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Acquire_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%get channel and exposure time info:
Channels=[get(handles.Brightfield_checkbox,'Value') get(handles.DAPI_checkbox,'Value') get(handles.DIC_checkbox,'Value') get(handles.GFP_checkbox,'Value') get(handles.RFP_checkbox,'Value') get(handles.FarRed_checkbox,'Value') get(handles.NileRed_checkbox,'Value')];
extimes=[get(handles.Brigtfield_extime,'Value') get(handles.DAPI_extime,'Value') get(handles.DIC_extime,'Value') get(handles.GFP_extime,'Value') get(handles.RFP_extime,'Value') get(handles.FarRed_extime,'Value') get(handles.NileRed_extime,'Value')];

%determine acquisition type:
if get(handles.Timecourse_checkbox,'Value')==1
    if get(handles.Multipoint_checkbox)==1
        handles.xylist=evalin('base','xyout');
        %need to setup timesettings (handles.timesettings);
        mm_multiTime(handles.mmc,get(handles.Outputdir_edit,'String'),get(handles.subdir_edit,'Value'),Channels,extimes,handles.xylist,handles.timesettings)
    elseif get(handles.Zstack_checkbox)==1
        mm_multiZ(handles.mmc,get(handles.Outputdir_edit,'String'),get(handles.subdir_edit,'Value'),Channels,extimes,handles.xylist,handles.timesettings,handles.zsettings)
    end
elseif get(handles.Wellsweep_checkbox,'Value')==1
    imageinfo=struct('Channels',{channels},'extimes',{extimes},'topdir',{get(handles.Outputdir_edit,'String')},'imsubdir',{get(handles.subdir_edit,'Value')},'fiduciary',{get(handles.Fiduciary_checkbox,'Value')},'source',{handles.vid});
    mm_wellsweep(handles.mmc,welltype,imageinfo)
elseif get(handles.Multipoint_checkbox,'Value')==1
    handles.xylist=evalin('base','xyout');
    mm_multipoint(handles.mmc,get(handles.Outputdir_edit,'String'),get(handles.subdir_edit,'Value'),Channels,extimes,handles.xylist)
elseif get(handles.Zstack_checkbox,'Value')==1
    
else % get(handles.Zstack_checkbox,'Value')==0 && get(handles.Multipoint_checkbox,'Value')==0 && get(handles.Wellsweep_checkbox,'Value')==0 && get(handles.Timecourse_checkbox,'Value')==0
    mm_snap1(handles.mmc,get(handles.Outputdir_edit,'String'),get(handles.subdir_edit,'Value'),imagecount,Channels,extimes,get(handles.Autosave_checkbox,'Value'));
end

% --- Executes on button press in Browse_pushbutton.
function Browse_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imtopdir=uigetdir(get(handles.outputdir_edit,'String'),'Select Directory for Images');
set(handles.Outputdir_edit,'String',imtopdir);
guidata(hObject,handles)

% --- Executes on button press in Multipoint_checkbox.
function Multipoint_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Multipoint_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);

% --- Executes on selection change in Wellsweep_popupmenu.
function Wellsweep_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to Wellsweep_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Wellsweep_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Wellsweep_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TimeSettings_pushbutton.
function TimeSettings_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to TimeSettings_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.timesettings=mm_timesetup(handles.mmc);

% --- Executes on button press in xyList_pushbutton.
function xyList_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to xyList_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mm_xymark();

% --- Executes on button press in Autosave_checkbox.
function Autosave_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Autosave_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Fiduciary_checkbox.
function Fiduciary_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Fiduciary_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Fiduciary_checkbox
