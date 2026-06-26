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
```

## my hosts

| name    | system type  | description                                 |
| ------- | ------------ | ------------------------------------------- |
| abydos  | x86_64-linux | my main laptop with an i7-13620H a RTX 4050 |
| gehenna | x86_64-linux | wsl (blasphemy, i know)                     |
| trinity | x86_64-linux | netcup vps (4 vCores + 8gb ram)             |

## attributions

- [fazzi/nixohess](https://gitlab.com/fazzi/nixohess) - for inspiring the design of my config
- [nix-community/home-manager](https://github.com/nix-community/home-manager) - for the DAG system
