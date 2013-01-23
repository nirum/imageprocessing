## [Image Processing toolbox](http://niru.org/imageprocessing/)

**written by Niru Maheswaranathan (nirum@stanford.edu)**

This toolbox contains some useful scripts for generating and processing image ensembles in Matlab.

***
#### Setup
1. This toolbox uses images from the van Hateren natural image database. Download the images from [the Bethge lab](http://bethgelab.org/datasets/vanhateren/). A mirror is also hosted by Paul Ivanov [at his website](http://pirsquared.org/research/vhatdb/).
2. Specify the path to the image set you want to use (either the linearized .iml images or the deblurred, or calibrated, .imc images) in **setupIPT.m**
3. Make sure to run **setupIPT.m** before using the toolbox. You can add the entire toolbox to your path using **pathtool** in Matlab.

#### Requirements
To use the toolbox, you'll need a copy of Matlab. I haven't figured out exactly what versions are supported yet. It might also work with Octave.

***
#### List of functions
Secondary helper functions included in the *helper_functions* folder are not included in this list.

- **setupIPT.m** Sets up some paths for the imageprocessing toolbox (IPT). Run this before using the toolbox!
- **generate_samples.m** Generates (or samples) image patches from different model classes (gaussian noise, pink noise, natural images, or the dead leaves model)
- **loadimage.m** Loads an image from the van Hateren database
- **oneoverf.m** Generates 1/f noise (from Lawrence Cormack)
- **plot_patches.m** Plots rows of a matrix as images in a grid. Useful for visualizing the output of generate_samples.m
- **downsample2.m** 2D downsampling function
- **upsample2.m** 2D upsampling function
- **gabor.m** Generates a 2D gabor function

***
#### License
This code is provided for non-commercial research use only. There are no guarantees that anything works, but let me know if something doesn't work and I will fix it.
