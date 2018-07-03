function data=keep_last_2000(data)
b=size(data,1);


if b>2100
    data=data(b-2100:b-100,:);
else
    data=data(b-1100:b-100,:);
end