clear all; 

load ('callmetest.mat');

f1 = imresize(f1,0.1);
f2 = imresize(f2,0.1);
f3 = imresize(f3,0.1);
f4 = imresize(f4,0.1);
f5 = imresize(f5,0.1);
f6 = imresize(f6,0.1);

% imshow(f1); figure; imshow(f2); figure; imshow(f3);

c1 = callMe2(f1);
c2 = callMe2(f2);
c3 = callMe2(f3);
c4 = callMe2(f4);
c5 = callMe2(f5);
c6 = callMe2(f6);

c1 = transpose(c1);
c3 = transpose(c2);
c2 = transpose(c3);
c4 = transpose(c4);
c5 = transpose(c5);
c6 = transpose(c6);


p1 = padding_leftright(c1);
p2 = padding_leftright(c2);
p3 = padding_leftright(c3);
p4 = padding_leftright(c4);
p5 = padding_leftright(c5);
p6 = padding_leftright(c6);


