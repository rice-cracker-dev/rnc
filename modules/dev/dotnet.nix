{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [dotnet-sdk];
    sessionVariables.DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet/";
  };
}
