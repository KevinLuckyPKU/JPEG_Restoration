function imgout = Quan_clipping(imgrec,imgjpg,qt,thre)

if nargin<4
    thre=.5;
end
[m n]=size(imgrec);
for ii=1:8:m
    for jj=1:8:n
        b=imgjpg(ii:ii+7,jj:jj+7);bt=dct2(b);
        brec=imgrec(ii:ii+7,jj:jj+7);brect=dct2(brec);
        te=min(brect,bt+thre*qt);
        te=max(te,bt-thre*qt);
        imgout(ii:ii+7,jj:jj+7)=idct2(te);
    end
end