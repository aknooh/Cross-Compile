# Cross Compile 

Shell scripts for automatically downloading the source code and cross compiling `iw tool` and `rfkill` for Arm architecture.

## Installation

No installation is required. Just download and use the scripts. 

```bash
git clone git@github.com:aknooh/Cross-Compile.git
```

## Usage
### To build `iw tool`

```bash
./build_iw.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
   100   162  100   162    0     0    871      0 --:--:-- --:--:-- --:--:--   870
   100  107k  100  107k    0     0   262k      0 --:--:-- --:--:-- --:--:--  262k
```

### To build `rfkill tool`
```bash
./build_rfkill.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
100  8197  100  8197    0     0  61976      0 --:--:-- --:--:-- --:--:-- 62098
```

## Assumptions
- [GNU ARM cross-compile toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads)  installed on host machine

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[MIT](https://choosealicense.com/licenses/mit/)
