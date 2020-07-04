function varargout = App(varargin)
% APP MATLAB code for App.fig
%      APP, by itself, creates a new APP or raises the existing
%      singleton*.
%
%      H = APP returns the handle to a new APP or the handle to
%      the existing singleton*.
%
%      APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APP.M with the given input arguments.
%
%      APP('Property','Value',...) creates a new APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before App_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to App_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help App

% Last Modified by GUIDE v2.5 25-May-2020 16:18:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @App_OpeningFcn, ...
                   'gui_OutputFcn',  @App_OutputFcn, ...
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


% --- Executes just before App is made visible.
function App_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to App (see VARARGIN)

% Choose default command line output for App
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes App wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = App_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function nombre_Callback(hObject, eventdata, handles)
% hObject    handle to nombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nombre as text
%        str2double(get(hObject,'String')) returns contents of nombre as a double
Texto=get(hObject,'String');
handles.Nombre=Texto;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function nombre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sesion_Callback(hObject, eventdata, handles)
% hObject    handle to sesion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sesion as text
%        str2double(get(hObject,'String')) returns contents of sesion as a double
Texto=get(hObject,'String');
handles.Sesion=Texto;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function sesion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sesion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in comenzar.
function comenzar_Callback(hObject, eventdata, handles)
% hObject    handle to comenzar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    set(handles.camara,'visible','on');
    Video=videoinput('winvideo',1,'MJPG_1280x720');%RGB24_640x480');
    set(Video,'FramesPerTrigger',Inf);
    axes(handles.camara);
    handles.Video=Video;
    start(Video); 
    for i=1:300
        flushdata(Video);
        Frame=getsnapshot(Video);
        Frame_Marcado=insertMarker(Frame,[640 360],'+','color','red','size',200);%insertMarker(Frame,[320 240],'+','color','red','size',200);
        imshow(Frame_Marcado);
    end
    stop(Video);
    guidata(hObject, handles);
catch me
    stop(Video);
    guidata(hObject, handles);
end

% --- Executes on button press in foto.
function foto_Callback(hObject, eventdata, handles)
% hObject    handle to foto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    Video=handles.Video;
    start(Video);
    for i = 1:1 
        Frame=getsnapshot(Video);
    end
    Frame=rgb2gray(Frame);
    imwrite(Frame,strcat('C:\Users\chuy1\OneDrive\Escritorio\Mario\Pruebas\Molde\',handles.Nombre,'_',handles.Sesion,'.png'));
    axes(handles.camara);
    imshow(Frame);
    w = waitforbuttonpress;
    stop(Video);
    guidata(hObject, handles);
catch me
    stop(Video);
    guidata(hObject, handles);
end

% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)
% hObject    handle to grabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sca;
Screen('Preference', 'SkipSyncTests', 1);
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

screens = Screen('Screens');% Get the screen numbers
screenNumber = max(screens);% Draw to the external screen if avaliable
white = WhiteIndex(screenNumber);% Define black and white
black = BlackIndex(screenNumber);
grey = white / 2;
% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
% Here we calculate the radial distance from the center of the screen to
% the X and Y edges
xRadius = windowRect(3) / 2;
yRadius = windowRect(4) / 2;
% Screen resolution in Y
screenYpix = windowRect(4);
% Number of white/black circle pairs
rcycles = 8;
% Number of white/black angular segment pairs (integer)
tcycles = 24;
% Now we make our checkerboard pattern
xylim = 2 * pi * rcycles;
[x, y] = meshgrid(-xylim: 2 * xylim / (screenYpix - 1): xylim,...
    -xylim: 2 * xylim / (screenYpix - 1): xylim);
at = atan2(y, x);
checks = ((1 + sign(sin(at * tcycles) + eps)...
    .* sign(sin(sqrt(x.^2 + y.^2)))) / 2) * (white - black) + black;
circle = x.^2 + y.^2 <= xylim^2;
checks = circle .* checks + grey * ~circle;
% Now we make this into a PTB texture
radialCheckerboardTexture  = Screen('MakeTexture', window, checks);
% Draw our texture to the screen
Screen('DrawTexture', window, radialCheckerboardTexture);
% Flip to the screen
Screen('Flip', window);
S=load('gong.mat');
try
    D1=vision.CascadeObjectDetector('RightEye');
    D2=vision.CascadeObjectDetector('LeftEye');
    Video=handles.Video;
    Vp=zeros(2,12240);
    V=VideoWriter(strcat('C:\Users\chuy1\OneDrive\Escritorio\Mario\Pruebas\Videos\',handles.Nombre,'_',handles.Sesion));
    V.FrameRate=17;
    V.Quality=25;
    n=0;
    start(Video);
    open(V);
     a=arduino('COM3','Mega2560');
     writeDigitalPin(a,'D12',0);
    for i = 1:12240
        tic
        Frame=getsnapshot(Video);
        writeVideo(V,Frame);
        if rem(fix(i/1020),2)==1
            writeDigitalPin(a,'D12',1);
            writeDigitalPin(a,'D13',1);
            Vp(1,i)=2;
        else
            Frame_Recortado=Frame(170:240,270:370);
                D=D1(Frame_Recortado);
                if numel(D)~=0
                    Vp(1,i)=0;
                     writeDigitalPin(a,'D12',0);
                     writeDigitalPin(a,'D13',0);
                end
                if numel(D)==0
                    Vp(1,i)=1;
                     writeDigitalPin(a,'D12',1);
                     writeDigitalPin(a,'D13',1);
                end
        end
        n=n+toc;
        Vp(2,i)=n;
        if mod(i,1020)==0
            sound(S.y);
        end
        clc
        flushdata (Video);
    end
     writeDigitalPin(a,'D12',1);
     writeDigitalPin(a,'D13',1);
    close(V);
    stop(Video);
    nombre=fopen(strcat('C:\Users\chuy1\OneDrive\Escritorio\Mario\Pruebas\Registro\',handles.Nombre,'_',handles.Sesion,'.txt'),'w');
    fprintf(nombre,'%6s %11s\n','Parpadeo','tiempo');
    fprintf(nombre,'%6i %12.3f\n',Vp);
    fclose(nombre);
    S=load('handel.mat');
catch me
    stop(Video);
    guidata(hObject, handles);
end
sound(S.y);
% KbStrokeWait;
sca;


% --- Executes on key press with focus on comenzar and none of its controls.
function comenzar_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to comenzar (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
