{
  inputs,
  self,
  ...
}:
inputs.glfw3-minecraft-fix.legacyPackages.${self.stdenv.hostPlatform.system}.glfw3-minecraft
