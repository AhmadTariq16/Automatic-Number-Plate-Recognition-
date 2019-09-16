function varargout = anprgui(varargin)
% ANPRGUI MATLAB code for anprgui.fig
%      ANPRGUI, by itself, creates a new ANPRGUI or raises the existing
%      singleton*.
%
%      H = ANPRGUI returns the handle to a new ANPRGUI or the handle to
%      the existing singleton*.
%
%      ANPRGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANPRGUI.M with the given input arguments.
%
%      ANPRGUI('Property','Value',...) creates a new ANPRGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before anprgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to anprgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help anprgui

% Last Modified by GUIDE v2.5 23-May-2019 11:06:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anprgui_OpeningFcn, ...
                   'gui_OutputFcn',  @anprgui_OutputFcn, ...
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


% --- Executes just before anprgui is made visible.
function anprgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to anprgui (see VARARGIN)

% Choose default command line output for anprgui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes anprgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = anprgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
% import the background image and show it on the axes
bg = imread('background.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');
% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.jpg';'*.bmp'},'File Selector');
image = strcat(pathname, filename);

setappdata(handles.figure1, 'image1', image)
axes(handles.axes4);
imshow(image)
%set(handles.edit1,'string',filename);
%set(handles.edit2,'string',image);

% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XTick',[])
set(gca,'YTick',[])
% Hint: place code in OpeningFcn to populate axes4


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% t  = timer('timerfcn', {@graficar, gcf},'Period',0.1);
% start(t);
t1=clock;

image_path = getappdata(handles.figure1, 'image1');

image_uploaded = imread(image_path);
image_uploaded = imresize(image_uploaded,0.1);

%characterisolated = callMe(image_uploaded);
[i1 i2 i3 characterisolated] = callMe(image_uploaded);

axes(handles.axes5);
imshow(i1);

axes(handles.axes7);
imshow(i2);

axes(handles.axes14);
imshow(i3);

toshow = cell2mat(characterisolated);

axes(handles.axes11);
imshow(toshow);

characterisolated = transpose(characterisolated);
padded_data = padding_leftright(characterisolated);

predict = predictionFunction(padded_data);

set(handles.text8, 'String', predict);

t2=clock;
time=etime(t2,t1);  
set(handles.edit2,'String',time)


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XTick',[])
set(gca,'YTick',[])
% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function text8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.


% --- Executes during object creation, after setting all properties.
function axes11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XTick',[])
set(gca,'YTick',[])
% Hint: place code in OpeningFcn to populate axes11



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XTick',[])
set(gca,'YTick',[])
% Hint: place code in OpeningFcn to populate axes14


% --- Executes during object creation, after setting all properties.
function axes7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'XTick',[])
set(gca,'YTick',[])
% Hint: place code in OpeningFcn to populate axes7


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes4,'reset');
cla(handles.axes5,'reset');
cla(handles.axes7,'reset');
cla(handles.axes14,'reset');
cla(handles.axes11,'reset');
set(handles.text8, 'String', '');
%arrayfun(@cla,findall(0,'type','axes'))