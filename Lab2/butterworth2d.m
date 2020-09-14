function out = butterworth2d(im,dL, dH, n)
out = butterlp(im, dL, n) + butterhp(im, dH,n);

% direct 2D butterwork bandstop filter doesn't perform well when the band is narrow. 
% out = H = 1./ (1+ (((X.^2+Y.^2).^1/2.*W)./(X.^2+Y.^2-D0^2)).^(2*n)); % 2d band stop
end

function out = butterhp(im,d,n) % local func
    h = size(im,1);
    w = size(im,2);
    enhance_x = 3;
    enhance_y = 1;
    [x,y] = meshgrid(-floor(w/2):floor(w-1)/2, -floor(h/2):floor(h-1)/2);
    out = 1./(1+(d^2./((enhance_x*x).^2+enhance_y*y.^2)).^n);
end

  
function out = butterlp(im, d, n)
    out = 1 - butterhp(im, d, n);
end

