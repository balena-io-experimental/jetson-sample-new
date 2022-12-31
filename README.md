# jetson-sample-new
Examples of creating containers for CUDA and OpenCV on Jetson devices (Nano, TX2, Xavier and Orin) running on balenaOS.

## Installation

You can deploy this project to your Jetson device simply by using the button below:

[![balena deploy button](https://www.balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/balena-io-experimental/jetson-sample-new)


If you don't have a balena account, you will be prompted to create one. Otherwise you can use the [balenaCLI](https://www.balena.io/docs/reference/balena-cli/) and push this project to a fleet of one or more devices.

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

You can use the Dockerfile in our CUDA sample as a template for building your own containers that may need CUDA support. (Installing and building the cuda samples can be removed to save space and build time.)

### OpenCV examples

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






In the CUDA container, start the X display server and run the prebuilt sample apps:
```
    $ X &
    $ ./clock
    $ ./deviceQuery
    $ ./postProcessGL
    $ ./simpleGL
    $ ./simpleTexture3D
    $ ./smokeParticles
```

In the OPENCV container, issue the following command:
`export DISPLAY=:0`

Then type one of the following lines:

```
startx ./example_ximgproc_fourier_descriptors_demo  
startx ./example_ximgproc_paillou_demo corridor.jpg  
```
