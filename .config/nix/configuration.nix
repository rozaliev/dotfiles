{ pkgs, lib, ... }:
{
   imports = [ ./services/languagetool.nix ];

   nix = {
    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ 
    home-manager
    fish
    kitty
    nixfmt
    duf
    dua
    ripgrep
    peco
    fd
    mpv
    qbittorrent
    rnix-lsp
    jetbrains-mono
    bat
    gitui
    speedtest-rs
    jq
    socat
    rustup
    kitty
    mas
    marksman
    taplo
    nodejs_latest
    languagetool
    ltex-ls
    fasttext
    trunk
    pkg-config
    gitoxide
    zk
    jujutsu
    discord
  ];


  programs.fish.enable = true;

  homebrew.enable = true;
  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap";
    upgrade = true;
  };
  homebrew.brewPrefix = "/opt/homebrew/bin";

  # These app IDs are from using the mas CLI app
  # mas = mac app store
  # https://github.com/mas-cli/mas
  #
  # $ mas search <app name>
  #
  homebrew.masApps = {
  };
  homebrew.taps = [
    "koekeishiya/formulae"
  ];
  homebrew.brews = [
    "yabai"
    "skhd"
    "openssl@3"
    "yq"
    "zig"
    "exercism"
  ];
  homebrew.casks = [
    "firefox"
    "obsidian"
    "telegram-desktop"
  ];
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  security.pam.enableSudoTouchIdAuth = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      jetbrains-mono
    ];
  };

  users.users.erz = {
    createHome = false;
    home = "/Users/erz";
    isHidden = false;
    shell = pkgs.fish;
  };
}