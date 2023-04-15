{ config, pkgs, lib, ... }:

{
	imports = [ ./hardware-configuration.nix ];

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = "experimental-features = nix-command flakes";
	};

	nixpkgs.config = {
		allowUnfree = true;
		unstable = true;
	};

	boot.loader = { 
		grub = {
			enable = true;
			version = 2;
			device = "nodev";
			efiSupport = true;
			useOSProber = true;
		};

		efi.canTouchEfiVariables = true;
	}; 

	networking.hostName = "paris";

	time.timeZone = "America/Sao_Paulo";

	i18n.defaultLocale = "en_US.UTF-8";

	console = {
		font = "Lat2-Terminus16";
		keyMap = lib.mkForce "br-abnt2";
		useXkbConfig = true;
	};

	users.users.andrei = {
		isNormalUser = true;
		extraGroups = [ "wheel" "audio" "video" "input" "power" "network" ];
		shell = "/run/current-system/sw/bin/zsh";
	};

	fonts.fonts = with pkgs; [
		jetbrains-mono
	];

	security.rtkit.enable = true;

	services = {
		openssh.enable = true;

		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};
	};

	xdg.portal.wlr.enable = true;

	hardware.opengl.enable = true;

	environment.systemPackages = with pkgs; [
		clang
		exa
		fd
		ffmpeg
		firefox
		foot
		fzf
		gimp
		git
		imagemagick
		mpd
		mpv
		nnn
		obs-studio
		p7zip
		pamixer
		ripgrep
		river
		tmux
		tofi
		vis
		w3m
		yambar
		yt-dlp
		zig
		zsh
	];

	system.stateVersion = "22.11";
}
