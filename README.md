# jetson-nano-sample-new
Jetson Nano samples using new packages

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
