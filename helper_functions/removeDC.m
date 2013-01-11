%removeDC: Removes DC component from a signal
%
% Centers the *rows* of a signal x (vector or matrix)
%
% USAGE:
%   [y mu] = removeDC(x);
%
% RETURNS:
%   y: the centered signal(s)
%  mu: the mean that was removed
%
% VERSION 1.0, Tue Nov  6 10:40:24 2012     Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

function [y mu] = removeDC(x)

    mu = mean(x,2);
    y = x - mu*ones(1,size(x,2));
