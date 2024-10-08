# jetson-sample-new
Examples of creating containers for CUDA and OpenCV on Jetson devices (Nano, TX2, Xavier and Orin) running on balenaOS.

**NOTE**: We are working on updating the Jetson Orin examples in this repository to Jetpack 6.

## Installation

You can deploy this project to your Jetson device simply by using the button below:

[![balena deploy button](https://www.balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/balena-io-experimental/jetson-sample-new)


If you don't have a balena account, you will be prompted to create one. Otherwise you can use the [balenaCLI](https://www.balena.io/docs/reference/balena-cli/) and push this project to a fleet of one or more devices.

This project uses [multiple Dockerfiles](https://www.balena.io/docs/learn/develop/dockerfile/#multiple-dockerfiles) so it will build for the proper device based on the default device you select for your fleet.

NOTE: You can use the Dockerfile.jetson-agx-orin-devkit file for any Orin device.

## How to use

### CUDA examples
The cuda container has some sample programs that use CUDA for real time graphics. To run these samples, SSH into the app container using the balenaCloud terminal or CLI. Connect your Jetson device to a monitor before issuing these commands.

First, start the X11 window system which will provide graphic support on the display attached to the Jetson:

`X &`

(Note the `&` causes the process to run in the background and return our prompt, although you may need to hit enter more than once to get the prompt back.)

The most visually impressive demo is called “smokeParticles” and can be run by typing the following command:

`./smokeParticles`

To stop the demo you can hit CTRL + C. Below are the commands to run a few other demos, some of which just return information to the terminal without generating graphics on the display.
```
./deviceQuery
./simpleTexture3D
./simpleGL
./postProcessGL
```

For Jetson Orin devices on Jetpack 6, you'll need to use the full path to the sample demos:
```
/cuda-samples/Samples/1_Utilities/deviceQuery/deviceQuery
/cuda-samples/Samples/0_Introduction/simpleTexture3D/simpleTexture3D
/cuda-samples/Samples/5_Domain_Specific/simpleGL/simpleGL
/cuda-samples/Samples/5_Domain_Specific/postProcessGL/postProcessGL
```

You can use the Dockerfile in our CUDA sample as a template for building your own containers that may need CUDA support. (Installing and building the cuda samples can be removed to save space and build time.)

### OpenCV examples

(Note: If you were running the CUDA examples above you may first have to kill the X server in that session before continuing below. To do that, 
type: `ps aux | grep "X"` then find the PID for the running X server and issue `kill <pid>` substituting the PID value for `<PID>`)

OpenCV will be accelerated by the GPU so it has the same CUDA components as the cuda container, and will be built inside the Dockerfile.

To see the OpenCV demos SSH into the app container using the balenaCloud terminal or CLI.

Enter the following command to direct our output to the first display:
`export DISPLAY=:0`
Now enter this command to start the X11 window system in the background:
`X &`
Finally, type one of the following lines to see the samples on the display:
```
./example_ximgproc_fourier_descriptors_demo
./example_ximgproc_paillou_demo corridor.jpg
```
If all goes well, you will see example images on the monitor plugged into the Jetson's HDMI port. (While these examples are not particularly exciting, they are meant to confirm that OpenCV is indeed installed.)



```
startx ./example_ximgproc_fourier_descriptors_demo  
startx ./example_ximgproc_paillou_demo corridor.jpg  
```
