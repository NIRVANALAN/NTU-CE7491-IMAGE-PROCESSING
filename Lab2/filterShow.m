function filterShow(f,vis_type)
    % visualize a frequency filter, in grey scale or mesh
    %
    if nargin<2
    vis_type='mesh';
    end
    fl = log(1+abs(f));
    fm = max(fl(:));
    scaledFilter = im2uint8(fl/fm);
    if (strcmp(vis_type, 'grey'))
    imshow(scaledFilter) % scale decimals into [0,256]
    else
        mesh(scaledFilter);
%         colormap jet
    end
end