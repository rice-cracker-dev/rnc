{inputs, ...}:
inputs.nixpkgs.lib.extend (self: super: {
  rnc = import ../lib {
    lib = self;
  };
})
