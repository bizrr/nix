{ pkgs, inputs, ... }:

{
  imports =
    [ 
      ../common
      ./hardware-configuration.nix
      ../../modules/services
      inputs.home-manager.nixosModules.default
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  users.users.royl = {
    isNormalUser = true;
    description = "Roy Långsjö";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      thefuck
    ];
    shell = pkgs.zsh;
    useDefaultShell = true;
    ignoreShellProgramCheck = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "royl" = import ./home.nix;
    };
  };
  
  environment.systemPackages = with pkgs; [
    nix-prefetch-github
    wget
    xsel
    wineWowPackages.stable
  ];

  # programs.firefox.enable = true;
  # services.openssh.enable = true;

 #########################################################
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "fi";
    variant = "nodeadkeys";
  };
  console.keyMap = "fi";

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
