%loadimage.m
% Loads an image from the van Hateren database.
% (make sure you have run setup.m first)
%
% USAGE:
%  img = loadimage(idx, rescale)
%
% PARAMETERS:
%  idx is the index of the image to load. Valid indices are from 1 to 4212
%  If rescale is set to true, the image is scaled to be between [0 255]
%
% VERSION 1.1, Fri Jan 11 16:12:45 2013         adding more comments
% VERSION 1.0, Fri Apr 06 13:40:55 2012         Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

function img = loadimage(idx, rescale)

    if idx < 1 || idx > 4212 || round(idx) ~= idx
        error('Index must be between 1 and 4212.');
    end

    if nargin < 2
        rescale = false;        % default to no rescaling
    else
        if ~islogical(rescale)
            error('The second parameter (rescale) must be a logical.');
        end
    end

    % width and height of images in the database
    w = 1536; h = 1024;

    % generate filename (prefix must be loaded from setup.m!)
    setupIPT;
    fname = [vanhateren sprintf('imk%05.0f',idx) imgtype];              % load filename

    % load file
    file = fopen(fname,'rb','ieee-be');                             % open file
    if file == -1
        error('Invalid file index. Try a new index, or make sure the filename is correct.');
    end

    % read image
    img = fread(file, [w, h], 'uint16')';                           % load image

    if rescale
        img = round(255*(img-min(img(:)))/max(img(:)));             % scale image to [0 255]
    end

    fclose(file);                                                   % close the file
