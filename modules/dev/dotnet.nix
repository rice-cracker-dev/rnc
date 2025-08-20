{pkgs, ...}: {
  environment = {
    systemPackages = [pkgs.dotnet-sdk];
    sessionVariables.DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet/";
  };
}
