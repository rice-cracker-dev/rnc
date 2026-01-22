# taken from https://github.com/diniamo/niqspkgs/blob/main/pkgs/helium.nix
{
  appimageTools,
  fetchurl,
  lib,
}: let
  name = "helium";
  pname = name;
  version = "0.8.3.1";
  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
    hash = "sha256-GGltZ0/6rGQJixlGz3Na/vAwOlTeUR87WGyAPpLmtKM=";
  };

  contents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit name pname version src;

    extraInstallCommands = ''
      mkdir -p $out/share/{lib/helium,applications}

      cp -r ${contents}/usr/share/* $out/share
      cp -r ${contents}/opt/helium/locales $out/share/lib/helium
      substitute ${contents}/helium.desktop $out/share/applications/helium.desktop \
        --replace-fail 'Exec=AppRun' "Exec=$out/bin/helium"
    '';

    meta = {
      description = "Private, fast, and honest web browser based on Chromium";
      homepage = "https://github.com/imputnet/helium-chromium";
      changelog = "https://github.com/imputnet/helium-linux/releases/tag/${version}";
      platforms = ["x86_64-linux"];
      license = lib.licenses.gpl3;
      mainProgram = "helium";
    };
  }
