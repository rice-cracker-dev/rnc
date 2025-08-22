{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [dotnet-sdk jetbrains.rider];
    sessionVariables.DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet/";
  };
}
