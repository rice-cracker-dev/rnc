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

## My hosts

| name    | system type  | description                                 |
| ------- | ------------ | ------------------------------------------- |
| abydos  | x86_64-linux | my main laptop with an i7-13620H a RTX 4050 |
| gehenna | x86_64-linux | wsl (blasphemy, i know)                     |

## attributions

this nix config took some inspirations from these repos:

- [fazzi/nixohess](https://gitlab.com/fazzi/nixohess)
