# vscode-server-ubuntu16

A specially patched VS Code Server that runs on Ubuntu 16.04.

This repository is based on [vscode-server-centos7](https://github.com/MikeWang000000/vscode-server-centos7). It tracks its upstream releases through the `upstream` submodule and applies [Ubuntu 16.04 build changes](./patches/ubuntu16.patch) before making its own releases.

## Quick Start

1. Download a tarball from the [Releases](../../releases) page to your Ubuntu 16.04 server.

2. Execute the following commands on your server:

    ```bash
    mkdir -p ~/.vscode-server
    tar xzf vscode-server_*.tar.gz -C ~/.vscode-server --strip-components 1
    ~/.vscode-server/code-latest --patch-now
    ```

3. Enjoy!


## Build from Source

1. Initialize the upstream source:

    ```bash
    git submodule update --init --recursive
    scripts/apply-ubuntu16-patch.sh
    ```

2. Install APT dependencies:

    ```bash
    cd upstream
    sudo scripts/apt-install.sh
    ```

3. Download additional dependencies:

    ```bash
    scripts/download-deps.sh
    ```

4. Start the build process:

    ```bash
    make
    ```

    You can specify the value of `ARCH` to build for different architectures:

    ```bash
    make ARCH=x64
    ```

    ```bash
    make ARCH=arm64
    ```

    ```bash
    make ARCH=armhf
    ```

Dependency installation is explicit: `make` does not invoke `apt-install.sh`. A full build process may take a long time since it involves compiling the glibc and GCC toolchains.


## Release Tracking

The `Sync upstream release` workflow checks the latest upstream release every six hours. When that release has no matching downstream release, it applies the Ubuntu 16.04 patch, builds x64, arm64 and armhf archives, tests the x64 archive on Ubuntu 16.04, then releases `v<upstream-version>-ubuntu16` with the corresponding source archive.


## License

This repository, including its Ubuntu 16.04 patch and release automation, is licensed under the [GNU General Public License v3.0](./LICENSE.txt). It includes modifications to [vscode-server-centos7](https://github.com/MikeWang000000/vscode-server-centos7), which is also licensed under the GNU General Public License v3.0.

Each release includes the corresponding source archive with the exact upstream source, Ubuntu 16.04 patch and build scripts.

Microsoft Visual Studio Code product license:  
https://code.visualstudio.com/license

Visual Studio Code - Open Source:  
https://github.com/microsoft/vscode/blob/main/LICENSE.txt

libfastjson:  
https://github.com/rsyslog/libfastjson/blob/master/COPYING

PatchELF:  
https://github.com/NixOS/patchelf/blob/master/COPYING

The GNU C Library:  
https://www.gnu.org/software/libc/manual/html_node/Copying.html

The GNU C++ Library:  
https://gcc.gnu.org/onlinedocs/libstdc++/manual/license.html
