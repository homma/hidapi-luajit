#### About

Sample codes using [HIDAPI library](https://github.com/libusb/hidapi) from LuaJIT on macOS

#### Prerequisites

- macOS
- [clang](https://clang.llvm.org)
- [hidapi](https://github.com/libusb/hidapi) (ex. `brew install hidapi`)
- [luajit](https://luajit.org) (ex. `brew install luajit`)

#### Preparation

generate the cdef file as below.

````sh
$ ./hidapi_cdef.sh
````

#### Usage

````sh
$ luajit dump_hid_device_info.lua
````
