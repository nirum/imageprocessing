%Normalize (z-score) an image patch
%
% Z-scores the pixels in an image patch. Useful pre-processing step.
%
% USAGE:
%   zimg = normalize(img)
%
% PARAMETERS:
%   img: the image to be normalized
%
% RETURNS:
%   zimg: the same image with zero mean and unit variance
%
%
% VERSION 1.0, Thu Jan 10 14:20:31 2013         Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

function zimg = normalize(img)

    zimg = (img - mean(img(:)))./std(img(:));
