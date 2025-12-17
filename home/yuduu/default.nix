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

    # Load environment variables (e.g. OPENAI_API_KEY) into Zed
    load_env = true;

    extensions = [
      "python"
      "go"
      "nix"
      # No need for "codex-cli" here; Zed’s Codex integration isn't a marketplace extension
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

    # IMPORTANT: Use FHS-wrapped Zed on NixOS so downloaded agents can run
    (zed-editor.fhsWithPackages (
      pkgs: with pkgs; [
        openssl
        zlib
      ]
    ))
  ];

  home.file.".config/zed/settings.json" = {
    source = jsonFormat.generate "zed-settings.json" zedSettings;
    force = true;
  };

  home.stateVersion = "25.05";
}
