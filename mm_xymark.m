function varargout = mm_xymark(varargin)
% MM_XYMARK M-file for mm_xymark.fig
%      MM_XYMARK, by itself, creates a new MM_XYMARK or raises the existing
%      singleton*.
%
%      H = MM_XYMARK returns the handle to a new MM_XYMARK or the handle to
%      the existing singleton*.
%
%      MM_XYMARK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MM_XYMARK.M with the given input arguments.
%
%      MM_XYMARK('Property','Value',...) creates a new MM_XYMARK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mm_xymark_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mm_xymark_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mm_xymark

% Last Modified by GUIDE v2.5 09-Dec-2009 16:58:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mm_xymark_OpeningFcn, ...
                   'gui_OutputFcn',  @mm_xymark_OutputFcn, ...
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


% --- Executes just before mm_xymark is made visible.
function mm_xymark_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mm_xymark (see VARARGIN)
handles.mmc=varargin{1};
handles.stage=handles.mmc.getXYStageDevice();
handles.xyout={};
% Choose default command line output for mm_xymark
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mm_xymark wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mm_xymark_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in mark_pushbutton.
function mark_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to mark_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
displayposition=[handles.mmc.getXPosition(handles.stage),handles.mmc.getYPosition(handles.stage)];
handles.xyout=cat(2,handles.xyout, displayposition);
set(handles.position_statictext,'String',num2str(displayposition))
guidata(hObject, handles);


% --- Executes on button press in finished_pushbutton.
function finished_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to finished_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

assignin('base','xyout',handles.xyout);
close(handles.figure1);
