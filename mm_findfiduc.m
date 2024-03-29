function varargout = mm_findfiduc(varargin)
% MM_FINDFIDUC M-file for mm_findfiduc.fig
%      MM_FINDFIDUC, by itself, creates a new MM_FINDFIDUC or raises the existing
%      singleton*.
%
%      H = MM_FINDFIDUC returns the handle to a new MM_FINDFIDUC or the handle to
%      the existing singleton*.
%
%      MM_FINDFIDUC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MM_FINDFIDUC.M with the given input arguments.
%
%      MM_FINDFIDUC('Property','Value',...) creates a new MM_FINDFIDUC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mm_findfiduc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mm_findfiduc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mm_findfiduc

% Last Modified by GUIDE v2.5 21-Dec-2009 22:44:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mm_findfiduc_OpeningFcn, ...
                   'gui_OutputFcn',  @mm_findfiduc_OutputFcn, ...
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


% --- Executes just before mm_findfiduc is made visible.
function mm_findfiduc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mm_findfiduc (see VARARGIN)

% Choose default command line output for mm_findfiduc
handles.output = hObject;
handles.mmc=varargin{1};
handles.welltype=varargin{2};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mm_findfiduc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mm_findfiduc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Yes_pushbutton.
function Yes_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Yes_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file path]=uigetfile('*.tif','Select Fiduciary Image');
handles.image=imread(strcat(path,file));
handles.offset=textread(strcat(path,'fiduciary.txt'));
mm_fiducoffset(handles.mmc,handles.image,handles.offset)
close(figure1)

% --- Executes on button press in No_pushbutton.
function No_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to No_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
