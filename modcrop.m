function imgs = modcrop(imgs, modulo)

tmpsz = size(imgs);
sz = tmpsz(1:2);
sz = sz - mod(sz, modulo);
imgs = imgs(1:sz(1), 1:sz(2),:);
% if mod(sz(1), modulo)~=0
%     imgs = padarray(imgs,[8-mod(sz(1), modulo) 0],'replicate','post');
% end
% if mod(sz(2), modulo)~=0
%     imgs = padarray(imgs,[0 8-mod(sz(2), modulo)],'replicate','post');
% end
