function CHAR = callMe(image,k)
k

I = image;
I1=rgb2gray(I);
I1=imadjust(I1,[0.3,0.7],[]);
I1=medfilt2(I1);


I2=edge(I1,'roberts',0.25,'both');

se=[1;1;1];
I3=imerode(I2,se);
se=strel('rectangle',[30,30]);
I4=imclose(I3,se);
I5=bwareaopen(I4,1000);
se=ones(1,40);
I6=imdilate(I5,se);


p1=regionprops(I6,'BoundingBox','Image','Area');
[y,x] = size(I6);
if length(p1)>=2
    loop=length(p1);
    area=zeros(1,10);
    for n=1:loop
        ar=p1(n).BoundingBox(3)/p1(n).BoundingBox(4);
        % Find the object with aspect ratio greater than 2,
        % the object is not on any 4 image boundaries,
        % then select the candidate with the largest area.
        if (ar>2 && p1(n).BoundingBox(1)>10 && p1(n).BoundingBox(2)>10 && ...
                (x - p1(n).BoundingBox(1) - p1(n).BoundingBox(3))>10 && ...
                (y - p1(n).BoundingBox(2) - p1(n).BoundingBox(4))>10)
            area(n)=p1(n).Area;
            if(max(area)==p1(n).Area)
                x1=floor(p1(n).BoundingBox(1));
                x2=floor(p1(n).BoundingBox(1)+p1(n).BoundingBox(3));
                y1=floor(p1(n).BoundingBox(2));
                y2=floor(p1(n).BoundingBox(2)+p1(n).BoundingBox(4));
                pe=I(y1:y2,x1:x2,:);
            end
        end
    end
else
    pe=imcrop(I,p1.BoundingBox);
end


% Accurate Detection and Extraction
level = graythresh(pe);
I7=im2bw(pe,level);
[y, x]=size(I7);
dimen=y*x;
para=floor(0.15*dimen);
I7=bwareaopen(I7,para);
%Boundingbox Method
p2=regionprops(I7,'BoundingBox','Image','Area');
pe2=imcrop(pe,p2.BoundingBox);
I8=imcrop(I7,p2.BoundingBox);
[y,x]=size(I8);
% Horizontal Projection Method
Black_y=sum(I8==0,2);
PY1=fix(y/2);
PY2=fix(y/2);
while (Black_y(PY1,1)>=1&&(PY1>1))
    PY1=PY1-1;
end
while (Black_y(PY2,1)>=1&&(PY2<y))
    PY2=PY2+1;
end
if (Black_y(PY2,1)==x)
    for n=1:x
        I8(PY2,n)=1;
    end
end
I9=I8(PY1:PY2,:,:);
% Vertical Wave Trough Method
White_x=sum(I8);
Black_x=sum(I8==0);
[pks,locs]=findpeaks(y-Black_x);
PX1=locs(1);
while(Black_x(PX1)==Black_x(PX1+1))
    PX1=PX1+1;
end
PX2=locs(length(locs));
I10=I8(:,PX1:PX2,:);
ae=pe2(PY1:PY2,PX1:PX2,:);


%Character Segmentation
% Binarisation
ae=imresize(ae,[120 nan]);
cs=ae;
level=graythresh(cs);
cs=im2bw(cs,level);


% Noise Clean-Up
% Set up horizontal and vertical boundaries
[y,x,z]=size(cs);
for n=1:x
    cs(y,n)=1;
    cs(1,n)=1;
end
for n=1:y
    cs(n,x)=1;
    cs(n,x-1)=1;
    cs(n,1)=1;
end
% Horizontal Cleaning
Black_y=sum(cs==0,2);
% Searching and Cleaning Upward
PY1=fix(y/2);
while (PY1>1&&Black_y(PY1,1)>10)
    PY1=PY1-1;
    if (Black_y(PY1,1)>=8/10*x)
        for n=1:x
            cs(PY1,n)=1;
        end
    end
end
if (Black_y(PY1,1)<10)
    for m=1:PY1
        for n=1:x
            cs(m,n)=1;
        end
    end
end
% Searching and Cleaning Downward
PY2=fix(y/2);
while (PY2<y&&Black_y(PY2,1)>10)
    PY2=PY2+1;
    if (Black_y(PY2,1)>=8/10*x)
        for n=1:x
            cs(PY2,n)=1;
        end
    end
end
if (Black_y(PY2,1)<10)
    for m=PY2:y
        for n=1:x
            cs(m,n)=1;
        end
    end
end
% Vertical Cleaning
Black_x=sum(cs==0);
% Searching and Cleaning Vertically
PX=1;
while (PX>=1&&PX<x)
    PX=PX+1;
    if (Black_x(PX)<=7)
        for n=1:y
            cs(n,PX)=1;
        end
    end
end


% Morphological Operation for Edge Enhancement
cs=~cs;
cs=bwareaopen(cs,500);
cs=~cs;
SE=strel('disk',1);
DIL=imdilate(cs,SE);
ERO=imerode(cs,SE);
SUB=imsubtract(DIL,ERO);
CONTRA=imadjust(SUB,[0.2 0.8],[0 1],0.1);
cs=logical(CONTRA);
%figure(21),imshow(cs),title('Morphological Operation for Edge Enhancement')

% Character Isolation Process
ERO1=imerode(cs,strel('line',70,0));
cs=imsubtract(cs,ERO1);
cs=imfill(cs,'holes');
cs=bwmorph(cs,'thin',1);
cs=imerode(cs,strel('line',3,90));
cs=bwareaopen(cs,500);
%figure(22),imshow(cs),title('Character Isolation')


% Character Detection and Segmentation
csproperty=regionprops(cs,'BoundingBox');
cslength=length(csproperty);


% Normalise all character images to 100 (Height) by 50 (Width).
for n=1:cslength
    sc{n}=imcrop(ae,csproperty(n).BoundingBox);
    SC{n}=imresize(sc{n}, [100 50]);
end

SClength=length(SC);

for n=1:SClength
    CHAR{n}=im2bw(SC{n},graythresh(SC{n}));
    CHAR{n}=~CHAR{n};
end

%Padding - Top and Bottom
for n=1:SClength
    CHAR{n} = padarray(CHAR{n},20,'both');
end

end