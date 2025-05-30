{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption map;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.types) str package listOf;

  cfg = config.home.font;

  mkFont = {
    family,
    font,
  }: ''
    <alias>
      <family>${family}</family>
      <prefer>
        <family>${font}</family>
      </prefer>
    </alias>
  '';

  mkFontOption = description:
    mkOption {
      inherit description;
      type = str;
    };

  dirs = concatStringsSep "\n" (map (package: "<dir>${package}/share/fonts</dir>") cfg.packages);

  serif = mkFont {
    family = "serif";
    font = cfg.serif;
  };

  sansSerif = mkFont {
    family = "sans-serif";
    font = cfg.sansSerif;
  };

  monospace = mkFont {
    family = "monospace";
    font = cfg.monospace;
  };

  emoji = mkFont {
    family = "emoji";
    font = cfg.emoji;
  };
in {
  options.home.font = {
    enable = mkEnableOption "enable home fontconfig configurations";

    packages = mkOption {
      type = listOf package;
      description = "a list of font packages to install";
    };

    serif = mkFontOption "set font for serif";
    sansSerif = mkFontOption "set font for sans-serif";
    monospace = mkFontOption "set font for monospace";
    emoji = mkFontOption "set font for emoji";
  };

  config.me = mkIf cfg.enable {
    files.".config/fontconfig/fonts.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        ${dirs}

        <match target="font">
          <edit name="rgba" mode="assign">
            <const>rgb</const>
          </edit>
        </match>

        ${serif}
        ${sansSerif}
        ${monospace}
        ${emoji}
      </fontconfig>
    '';
  };
}
