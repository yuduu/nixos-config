{ pkgs, ... }:

let
  jsonFormat = pkgs.formats.json { };
  zedSettings = {
    ui_font_size = 16;
    buffer_font_size = 16;
    theme = {
      mode = "system";
      light = "One Light";
      dark = "Ayu Dark";
    };
    load_env = true;
    extensions = [
      "python"
      "go"
      "nix"
      "codex-cli"
    ];
  };
in
{
  home.username = "yuduu";
  home.homeDirectory = "/home/yuduu";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    brave
    nil
    nixd
    zed-editor
  ];

  home.file.".config/zed/settings.json" = {
    source = jsonFormat.generate "zed-settings.json" zedSettings;
    force = true;
  };

  home.stateVersion = "25.05";
}
