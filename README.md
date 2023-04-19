# HDZGOGGLE Buildroot

[Buildroot](https://buildroot.org/) to generate OS images for the HDZero Goggles.

## sdcard

Booting from a sdcard:

```shell
./build.sh hdzgoggle_sdcard_defconfig
./build.sh
# image will be generated at output/images/sdcard.img
```

The image can be writen to an sdcard via dd `sudo dd if=output/images/sdcard.img of=/dev/sdc`
Alternatively a tool like [Balena Etcher](https://www.balena.io/etcher) can be used.

## flash

...comming soon..
