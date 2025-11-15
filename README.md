# Nullhave

Nullhave is an open-source operating system designed for learning, experimentation, and low-level system development. 
It provides a minimal kernel with basic functionality and tools to build, run, and test the system on a modern Linux environment. 
The project aims to help developers understand how operating systems work under the hood, from bootloading to kernel execution. 
Future goals include creating a duo-stage loader, implementing a small but functional kernel, and exploring custom drivers and memory management.
## Roadmap

- [ ] Make a Duo-Stage loader

- [ ] Write a kernel with a minimal set of functions


## Run Locally

Install dependencies
```bash
  sudo apt update
  sudo apt install wget git unzip nasm qemu-system-i386
```

Clone the project

```bash
  git clone https://github.com/Nullverity/Nullhave/
```

Create the necessary folders
```bash
  mkdir -p ~/opt/cross && cd ~/opt/cross
```
Download and unpack the tools
```bash
  wget https://github.com/lordmilko/i686-elf-tools/releases/download/15.2.0/i686-elf-tools-linux.zip
  unzip i686-elf-tools-linux.zip
```
Add the compiler to PATH
```bash
  echo 'export PATH=$HOME/opt/cross/bin:$PATH' >> ~/.bashrc
  source ~/.bashrc
```

Check i686-elf-gcc

```bash
  i686-elf-gcc -v
```
```bash
  Using built-in specs.
  COLLECT_GCC=i686-elf-gcc
  COLLECT_LTO_WRAPPER=/home/<username>/opt/cross/bin/../libexec/gcc/i686-elf/15.2.0/     lto-wrapper
  Target: i686-elf
  Configured with: ../gcc-15.2.0/configure --target=i686-elf --disable-nls --enable-languages=c,c++ --without-headers --prefix=/root/build-i686-elf/linux/output
  Thread model: single
  Supported LTO compression algorithms: zlib zstd
  gcc version 15.2.0 (GCC)
```
* *If you encounter an error, check that you have installed the compiler correctly by following the steps shown here.*


Go to the project directory

```bash
  cd Nullhave
```

Start the system

```bash
  make clean && make run
```
## License

[MIT](https://choosealicense.com/licenses/mit/)


## Authors

- [@Nullverity](https://github.com/Nullverity/)

