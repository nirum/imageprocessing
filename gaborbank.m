%Generates a bank of gabor filters
%
% AUTHOR: Niru Maheswaranathan
%         nirum@stanford.edu

width = 64;
height = 64;

thetas = 0;
phis = linspace(0,2*pi,11);
lambdas = round(logspace(1, 2, 6));
Sigmas = 10;
pxs = 0.5;
pys = 0.5;
%pxs = 0.1:0.2:0.9;
%pys = 0.1:0.2:0.9;

numGabors = length(thetas)*length(phis)*length(lambdas)*length(Sigmas)*length(pxs)*length(pys);
gabors = zeros(numGabors, width*height);
gidx = 1;

for tidx = 1:length(thetas)
    for pidx = 1:length(phis)
        for lidx = 1:length(lambdas)
            for sidx = 1:length(Sigmas)
                for xidx = 1:length(pxs)
                    for yidx = 1:length(pys)

                        % generate gabor
                        [x y F] = gabor('theta',  thetas(tidx),  ...
                                        'phi',    phis(pidx),    ...
                                        'lambda', lambdas(lidx), ...
                                        'Sigma',  Sigmas(sidx),  ...
                                        'px',     pxs(xidx),     ...
                                        'py',     pys(yidx),     ...
                                        'width',  width,         ...
                                        'height', height         ...
                                        );

                        % store the function
                        gabors(gidx,:) = F(:)';
                        gidx = gidx + 1;

                        % update progress
                        progressbar(gidx, numGabors, 50);

                    end
                end
            end
        end
    end
end
