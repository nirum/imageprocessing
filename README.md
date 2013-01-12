## Image Processing toolbox

**written by Niru Maheswaranathan (nirum@stanford.edu)**  

This toolbox contains some useful scripts for generating and processing image ensembles in Matlab. Right now it is empty but there is a lot more to come.

***
#### Setup
1. This toolbox uses images from the van Hateren natural image database. Download the images from [the Bethge lab](http://bethgelab.org/datasets/vanhateren/). A mirror is also hosted by Paul Ivanov [at his website](http://pirsquared.org/research/vhatdb/).
2. Specify the path to the image set you want to use (either the linearized .iml images or the deblurred, or calibrated, .imc images) in *setup.m*
3. Make sure to run *setup.m* before using the toolbox. You can add the entire toolbox to your path using *pathtool* in Matlab.

***
#### List of functions

- gabor.m _Generates a 2D gabor function_

***
#### License
This code is provided for non-commercial research use only. There are no guarantees that anything works. Feel free to use/modify to your heart's content.
