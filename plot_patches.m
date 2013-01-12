%plot_patches.m
% Plots rows of a matrix as images in a grid
%
% USAGE:
%  h = plot_patches(X, num, shuffle)
%
% PARAMETERS:
%  X is the matrix to plot. The rows of X are reshaped (assuming square images)
%       and plotted as images in a grid.
%  num is the number of images to show in the grid. By default, it is the number
%       of rows in X (but limited to being smaller than 50);
%  shuffle is a logical that determines whether or not to shuffle the rows of X
%       before plotting. If set to false, the first num rows of X are plotted.
%
% RETURNS:
%  h: A vector of figure handles to the images.
%
% VERSION 1.1, Fri Jan 11 16:37:00 2013         Adding some comments, cleaning up code
% VERSION 1.0, Tue Nov  6 15:12:17 2012         Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

function h = plot_patches(X,num,shuffle)

    if nargin < 3
        shuffle = 1;
    end

    if nargin < 2
        num = min(50,size(X,1));
    end

    if shuffle
        indices = randperm(size(X,1));
    else
        indices = 1:size(X,1);
    end

    X = X(indices(1:num),:);
    D = sqrt(size(X,2));
    m = ceil(sqrt(size(X,1)));
    n = ceil(size(X,1)/m);
    h = zeros(size(X,1),1);

    for j = 1:size(X,1)
        subplot(n,m,j);
        h(j) = imagesc(reshape(X(j,:),D,D), [min(X(:)), max(X(:))]);
        set(gca,'XTick',[],'YTick',[]);
        axis image;
    end

    colormap gray;
