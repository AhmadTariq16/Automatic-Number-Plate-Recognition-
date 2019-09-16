function CHAR = callMe(data)

temp2 = {};
for n = 1:length(data)
    temp = zeros(length(data{n}),20);
    temp2{n,1} = [temp data{n} temp];
end

CHAR = temp2;


