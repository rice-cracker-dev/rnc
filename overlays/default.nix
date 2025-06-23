{inputs}: (_: self: let
  final = {
    inherit inputs self;
  };
in {
  glfw3-minecraft = import ./glfw3-minecraft.nix final;
})
