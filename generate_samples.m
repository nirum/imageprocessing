%generate_samples.m
%
% Samples image patches from different image models.
%
% USAGE:
%  X = generate_samples(num_samples, patch_size, varargin);
%
%  Specify the model class from which to draw images using the 'model' argument.
%  Valid model classes are: 'gaussian' (gaussian noise), 'pink' (1/f noise),
%                           'natural' (van Hateren patches), 'deadleaves' (dead leaves model)
%  There are other optional parameters depending on the model class, listed below.
%  NOTE: Image patches are contrast normalized (z-scored).
%
% REQUIRED PARAMETERS:
%   num_samples: the number of image samples to draw
%   patch_size: the dimension of a patch edge (eg, 8 for 8x8 patches)
%
% OPTIONAL PARAMETERS:
%   'taper': Whether to taper the edges of the image patches,
%            useful for performing windowed 2D Fourier transforms (default: false)
%   'model': 'gaussian', 'pink', 'natural', 'deadleaves' (default is 'gaussian')
%     Model specific parameters:
%       Gaussian: 'covariance' (covariance matrix for colored Gaussian noise, default is the identity)
%       Pink: 'slope' (value of alpha in 1/f^alpha, default is 1)
%       Natural: num_images (number of large images to draw patches from, default is 25)
%       Dead Leaves: nbr_iter (number of iterations, default is 5000),
%                    shape (what shape the leaves are, either 'disk' [default] or 'square')
%
% RETURNS:
%   A matrix, X, where the rows are the vectorized patches. You can quickly visualize the
%   sampled image patches using plot_patches:
%   plot_patches(X);
%
% EXAMPLES:
%   X = generate_samples(10, 32, 'model', 'natural');           % Draw 10  32x32 patches from natural images
%   X = generate_samples(5, 8, 'model', 'pink', 'slope', 2);    % Draw 5   8x8   patches of 1/f^2 noise
%   X = generate_samples(250, 10, 'model', 'deadleaves');       % Draw 250 10x10 patches of dead leaves images
%
% VERSION 1.2, Fri Jan 11 16:43:42 2013         Fleshing out comments and examples
% VERSION 1.0, Tue Nov  6 14:40:25 2012         Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

function X = generate_samples(num_samples, patch_size, varargin);

    % Set up parameters
    setup;
    p = inputParser;
    img_models = {'gaussian','natural','deadleaves','pink'};
    defaultModel = 'gaussian';
    addRequired(p,'num_samples',@isnumeric);
    addRequired(p,'patch_size',@isnumeric);
    addOptional(p,'taper',false,@islogical);
    addOptional(p,'num_images',25,@isnumeric);
    addOptional(p,'covariance',-1,@isnumeric);
    addOptional(p,'nbr_iter',5e3,@isnumeric);
    addOptional(p,'slope',1,@isnumeric);
    addOptional(p,'shape','disk');
    addParamValue(p,'model',defaultModel,@(x) any(validatestring(x,img_models)));

    % Parse inputs
    parse(p,num_samples,patch_size,varargin{:});
    N = p.Results.num_samples;
    D = p.Results.patch_size;
    taper = p.Results.taper;
    model = p.Results.model;
    alpha = p.Results.slope;

    % generate tapering window, if necessary
    if taper
        window = makeWindow(D,D);
    end

    % set up model specific parameters
    switch model

        %% GAUSSIAN WHITE NOISE %%
        case 'gaussian'

            if p.Results.covariance == -1
                C = eye(D^2);
            else
                C = p.Results.covariance;
            end

            if taper
                X = (ones(N,1)*reshape(window, 1, D^2)).*randn(N,D^2)*sqrtm(C);
            else
                X = randn(N,D^2)*sqrtm(C);
            end

        %% PINK NOISE %%
        case 'pink'

            % initialize patch matrix
            X = zeros(N,D^2);

            % get number of image centers
            num_centers = ceil(N/p.Results.num_images);
            k = 1;

            % generate pink noise
            for i = 1:p.Results.num_images

                % load an image
                img = oneoverf(alpha, 512, 512);

                % pick random patch corners
                r = size(img,1); c = size(img,2);
                xr = randi(r-D,num_centers,1);
                xc = randi(c-D,num_centers,1);

                for j = 1:num_centers

                    % get patch
                    temp_patch = normalize(img(xr(j):(xr(j)+D-1), xc(j):(xc(j)+D-1)));

                    if taper
                        temp_patch = temp_patch.*window;
                    end

                    X(k,:) = temp_patch(:)';

                    % increment
                    k = k + 1;
                    if k > N
                        break;
                    end

                end

                progressbar(i,p.Results.num_images);

            end

        %% NATURAL IMAGE PATCHES %%
        case 'natural'

            % initialize patch matrix
            X = zeros(N,D^2);

            % get number of image centers
            num_centers = ceil(N/p.Results.num_images);
            k = 1;

            for i = 1:p.Results.num_images

                % load an image
                bad_img = 1;
                while bad_img
                    try
                        img = loadimage(randi(4212),true);
                        bad_img = 0;
                    catch exception
                        warning('Caught an invalid file index. Trying a new one.');
                    end
                end

                % pick random patch corners
                r = size(img,1); c = size(img,2);
                xr = randi(r-D,num_centers,1);
                xc = randi(c-D,num_centers,1);

                for j = 1:num_centers

                    % get patch
                    temp_patch = normalize(img(xr(j):(xr(j)+D-1), xc(j):(xc(j)+D-1)));

                    % taper edges for windowed FFT
                    if taper
                        temp_patch = temp_patch.*window;
                    end

                    X(k,:) = temp_patch(:)';

                    % increment
                    k = k + 1;
                    if k > N
                        break;
                    end

                end

                progressbar(i,p.Results.num_images);

            end

        %% DEAD LEAVES %%
        case 'deadleaves'

            % initialize patch matrix
            X = zeros(N,D^2);
            options = struct;
            options.shape = p.Results.shape;
            options.nbr_iter = p.Results.nbr_iter;

            % get number of image centers
            num_centers = ceil(N/p.Results.num_images);
            k = 1;

            % generate images
            for i = 1:p.Results.num_images

                % generate an image
                img = compute_dead_leaves_image(512,3,options);

                % pick random patch corners
                r = size(img,1); c = size(img,2);
                xr = randi(r-D,num_centers,1);
                xc = randi(c-D,num_centers,1);

                for j = 1:num_centers

                    % get patch
                    temp_patch = normalize(img(xr(j):(xr(j)+D-1), xc(j):(xc(j)+D-1)));

                    if taper
                        temp_patch = temp_patch.*window;
                    end

                    X(k,:) = temp_patch(:)';

                    % increment
                    k = k + 1;
                    if k > N
                        break;
                    end

                end

                progressbar(i,p.Results.num_images);

            end

    end

end
