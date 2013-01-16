%Generates a bank of gabor filters
%
% USAGE:
%   F = gaborbank(32, 'numOrientations', 8, 'numPhases', 10);
%
% PARAMETERS:
%   'numOrientations' number of orientations between 0 and 2*pi
%   'numPhases' number of phases between 0 and 2*pi
%   'numLambdas' number of spatial scales, from 'lambdaStart' to 'lambdaEnd'
%   'numScales' number of gaussian windowing scales from 'scaleStart' to 'scaleEnd'
%
% VERSION 1.0, Sat Jan 12 19:19:51 2013         Initial version
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

function F = gaborbank(dim, varargin)

    % Set up parameters
    p = inputParser;
    addRequired(p,'dim',@isnumeric);
    addOptional(p,'numOrientations',1,@isnumeric);
    addOptional(p,'numPhases',1,@isnumeric);

    addOptional(p,'numFreq',1,@isnumeric);
    addOptional(p,'freqStart',2,@isnumeric);
    addOptional(p,'freqEnd',8,@isnumeric);

    %addOptional(p,'numScales',1,@isnumeric);
    %addOptional(p,'scaleStart',1,@isnumeric);
    %addOptional(p,'scaleEnd',10,@isnumeric);

    %addOptional(p,'numLambdas',1,@isnumeric);
    %addOptional(p,'lambdaStart',1,@isnumeric);
    %addOptional(p,'lambdaEnd',10,@isnumeric);

    % Parse inputs
    parse(p, dim, varargin{:});
    dim = p.Results.dim;
    numOrientations = p.Results.numOrientations;
    numPhases = p.Results.numPhases;
    numFreq = p.Results.numFreq;

    %numScales = p.Results.numScales;
    %numLambdas = p.Results.numLambdas;

    % Make parameter vectors
    thetas = linspace(0, pi, numOrientations + 1);                                  % orientations
    phis = linspace(0, 2*pi, numPhases + 1);                                        % phases
    omegas = linspace(p.Results.freqStart, p.Results.freqEnd, numFreq);             % spatial frequencies

    %Sigmas = linspace(p.Results.scaleStart, p.Results.scaleEnd, numScales);         % gaussian windows
    %lambdas = linspace(p.Results.lambdaStart, p.Results.lambdaEnd, numLambdas);     % scales

    % number of filters
    thetas = thetas(2:end); phis = phis(2:end);
    numFilters = numOrientations*numPhases*numFreq;

    % generate filters
    F = zeros(numFilters, dim^2);
    filterIdx = 1;

    sigma = @(f) 0.4053*f.^(-1.039);
    for tidx = 1:length(thetas)
        for pidx = 1:length(phis)
            for fidx = 1:length(omegas)

                % generate gabor
                [x y z] = gabor('theta',  thetas(tidx),   ...
                                'phi',    phis(pidx),     ...
                                'omega',  omegas(fidx), ...
                                'sigma',  sigma(omegas(fidx)), ...
                                'width',  dim,           ...
                                'height', dim            ...
                                 );

                % store the function
                F(filterIdx,:) = z(:)';
                filterIdx = filterIdx + 1;

            end
        end
    end
