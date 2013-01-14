%Generate 2D Gabor Patch
%
% GABOR
%   Generates a spatially oriented sinusoidal grating multiplied by a gaussian
%   window. Gabor functions have been used to model simple cell receptive fields
%   and are commonly used filters for edge detection.
%
% USAGE
%   [x y F] = gabor(varargin)
%
%   Returns:
%       x: grid of x-values
%       y: grid of y-values
%       F: gabor function evaluated at (x,y) points
%
%   Parameters (Default):
%       theta  (2*pi): orientation of the gabor patch
%       phi    (2*pi): phase of the sinusoid
%       omega  (3): spatial frequency, in normalized units
%       sigma  (0.1): standard deviation of gaussian window, in normalized units
%       width  (256): width of generated image
%       height (256): height of generated image
%       px     (0.5): horizontal center of gabor patch, relative to the image width (must be between 0 and 1)
%       py     (0.5): vertical center of gabor patch, relative to the image height (must be between 0 and 1)
%
% EXAMPLE
%   [x y F] = gabor;
%   pcolor(x,y,F); axis image;
%   shading('interp'); colormap gray;
%
% VERSION 1.2, Mon Jan 14 11:38:25 2013     Switched over to normalized units
% VERSION 1.1, Thu Jan 10 17:47:35 2013     Added ability to modify the phase of the sinusoid
% VERSION 1.0, Thu Jul 12 09:47:52 2012     Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

function [x y F] = gabor(varargin)

    % Parse arguments using Matlab's inputParser
    p = inputParser;
    addParamValue(p,'theta',2*pi,@isnumeric);
    addParamValue(p,'phi',2*pi,@isnumeric);
    addParamValue(p,'omega',3,@isnumeric);
    addParamValue(p,'sigma',0.1,@isnumeric);
    addParamValue(p,'width',256,@isnumeric);
    addParamValue(p,'height',256,@isnumeric);
    addParamValue(p,'px',0.5,@isnumeric);
    addParamValue(p,'py',0.5,@isnumeric);
    p.KeepUnmatched = true;
    parse(p,varargin{:});

    % Generate mesh
    [x y] = meshgrid(linspace(0,1,p.Results.width), linspace(0,1,p.Results.height));

    % Center of gaussian window
    cx = p.Results.px;
    cy = p.Results.py;

    % Orientation
    x_theta=(x-cx)*cos(p.Results.theta)+(y-cy)*sin(p.Results.theta);
    y_theta=-(x-cx)*sin(p.Results.theta)+(y-cy)*cos(p.Results.theta);

    % Generate gabor
    F = exp(-.5*(x_theta.^2/p.Results.sigma^2+y_theta.^2/p.Results.sigma^2)).*cos(2*pi*p.Results.omega*x_theta + p.Results.phi);

    % normalize
    F = F./norm(F(:));

end
