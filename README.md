# rice's nix config

written by a weeb

## config structure

```
- hosts # per-machine modules
  - <system> # x86_64-linux, aarch64-linux, ...
    - <hostname> # system hostname
- parts # flake modules
  - lib # my libraries
- modules # shared modules
- configs # raw config for some programs
  - quickshell # my quickshell config
```

taken some inspirations from:

- [fazzi/nixohess](https://gitlab.com/fazzi/nixohess)
