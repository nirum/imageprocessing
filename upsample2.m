%upsample2.m
%
% 2D upsampling function.
%
% USAGE:
%  ds_img = upsample2(img, xfactor, yfactor)
%
% PARAMETERS:
%  img: 2D matrix/image to upsample
%  xfactor: amount to upsample in the x-direction/columns    (default is 2)
%  yfactor: amount to upsample in the y-direction/rows       (default is 2)
%
% VERSION 1.0, Wed Jan 23 15:45:19 2013         Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

function ds_img = upsample2(img, xfactor, yfactor)

    if nargin < 2
        xfactor = 2;
    end

    if nargin < 3
        yfactor = xfactor;
    end

    if nargin == 0
        error('You must suppy a matrix to upsample.');
    end

    ds_img = upsample(upsample(img, yfactor)', xfactor)';
