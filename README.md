# CentOS minimal

This repo builds a dependency image that is used to build the ossim library.  It also has a runtime image that injects the runtime portion of the ossim distribution into the centos image.

We will first need to create a dependency builder image that will be used to build the ossim libraries.

## Build Dependency Image

We will first need to create a dependency builder image that will be used to build the ossim libraries.

### Disable or modify private repos

If you do not have access to the private repositories you will have to remove the kakadu support or if you have kakadu you will need to point that to your kakadu.  You will need to edit the file [build-ossim.sh](./compile-ossim/build-scripts/build-ossim.sh) and modify the variables:

```bash
export KAKADU_ROOT_SRC=$OSSIM_DEPS_HOME/ossim-private/kakadu/v7_7_1-01123C
export KAKADU_LIBRARY=$KAKADU_ROOT_SRC/lib/Linux-x86-64-gcc/libkdu.a
export KAKADU_AUX_LIBRARY=$KAKADU_ROOT_SRC/lib/Linux-x86-64-gcc/libkdu_aux.a
```

If you do not have KAKADU support then you can comment out the variables above and then set the variable:

```bash
export BUILD_KAKADU_PLUGIN=OFF
```

If you have your own kakadu then you must modify the [checkout-kakadu.sh](./builder-image/checkout-scripts/checkout-kakadu.sh) to setup the kakadu you are using.

### Build Dependencies

```bash
cd build-image
./build.sh
```

The build script will produce the building image called **ossim-builder-minimal-centos:local**

which will contain the minimal necessary dependencies to build the ossim repos.

## Build OSSIM

```bash
cd compile-ossim
./build.sh
```

will create an artifact called **output/ossim-dist-minimal-centos.tgz** that contains the install of ossim headers, libraries, and executable.

## Build Runtime

If you desire a runtime image that has the runtime libraries of the distribution installed then you can build the following:

```bash
cd runtime
./build-docker.sh
```
