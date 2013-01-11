%Window generator for tapered FFTs
%
% Generates a 2D tapered windowing function. Used by multiplying with an image
% before taking a 2D Fourier transform to reduce artifacts due to boundary effects
% Thu Jan 10 13:57:26 2013
%
%
% USAGE:
%   win = makeWindow(M, N)
%
% PARAMETERS:
%   [M N] is the size of the image
%
% VERSION 1.0, Fri Jan 11 15:35:15 2013     Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

function win = makeWindow(M, N)

    w1 = cos(linspace(-pi/2, pi/2, M));
    w2 = cos(linspace(-pi/2, pi/2, N));
    win = w1' * w2;
