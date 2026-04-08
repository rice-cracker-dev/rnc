{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;

  buildWebLang = name: langservers: {
    inherit name;
    language-servers = langservers ++ ["vscode-eslint-language-server"];
    formatter = {command = getExe pkgs.prettier;};
  };
in {
  config.home.rum.programs.helix.languages = {
    language-server = {
      typescript-language-server.command = getExe pkgs.typescript-language-server;
      vscode-css-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
      vscode-eslint-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
      vscode-html-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
      vscode-json-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
      marksman.command = getExe pkgs.marksman;
      svelteserver.command = getExe pkgs.svelte-language-server;
      vuels.command = getExe pkgs.vue-language-server;
      astro-ls.command = getExe pkgs.astro-language-server;
      docker-language-server.command = getExe pkgs.docker-language-server;
      yaml-language-server.command = getExe pkgs.yaml-language-server;
    };

    languages = [
      (buildWebLang "typescript" ["typescript-language-server"])
      (buildWebLang "javascript" ["typescript-language-server"])
      (buildWebLang "tsx" ["typescript-language-server"])
      (buildWebLang "jsx" ["typescript-language-server"])
      (buildWebLang "typescript-language-server" ["typescript-language-server"])
      (buildWebLang "css" ["vscode-css-language-server"])
      (buildWebLang "html" ["vscode-html-language-server"])
      (buildWebLang "json" ["vscode-json-language-server"])
      (buildWebLang "markdown" ["marksman"])
      (buildWebLang "svelte" ["svelteserver"])
      (buildWebLang "vue" ["vuels"])
      (buildWebLang "astro" ["astro-ls"])
    ];
  };
}
