# a discord bot my friend wrote
# hosting it because why not
{
  makeWrapper,
  stdenv,
  python3,
  pins,
}: let
  pythonDeps = python3.withPackages (python-pkgs:
    with python-pkgs; [
      discordpy
      python-dotenv
    ]);
in
  stdenv.mkDerivation (final: {
    pname = "aronaldo";
    version = "0.0.0";

    src = pins.aronaldo;

    nativeBuildInputs = [makeWrapper];

    configurePhase = ''
      mkdir -p $out/share/aronaldo/
      cp -r ./* $out/share/aronaldo/
    '';

    postBuild = ''
      makeWrapper ${pythonDeps}/bin/python $out/bin/aronaldo \
        --add-flags "$out/share/aronaldo/main.py" \
        --chdir "$out/share/aronaldo"
    '';
  })
