%Setup for image processing toolbox
%
% Set up path locations and other information for use
% with the imageprocessing toolbox.
%
% VERSION 1.0, Fri Jan 11 15:45:17 2013         Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

% Add path to other functions
addpath('~/Documents/Code/toolbox/imageprocessing/helper_functions/');
addpath('~/Documents/Code/toolbox/imageprocessing/kovesi/phase');
addpath('~/Documents/Code/toolbox/imageprocessing/kovesi/freq');

% Location of van Hateren image database
vanhateren = '~/Documents/Data/images/';

% Type of images (linear or calibrated, .iml or .imc)
imgtype = '.iml';
