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
		systemd-boot.enable = true;
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

	fonts.fonts = with pkgs; [
		jetbrains-mono
		ibm-plex
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

	programs = {
		zsh.enable = true;
		git.enable = true;
		tmux.enable = true;
		
		fzf = {
			fuzzyCompletion = true;
			keybindings = true;
		};
	};

	environment.binsh = "${pkgs.dash}/bin/dash";

	users.users.andrei = {
		isNormalUser = true;
		extraGroups = [ "wheel" "audio" "video" "input" "power" "network" ];
		shell = pkgs.zsh;
		packages = with pkgs; [
			alacritty
			ardour
			audacity
			brave
			discord
			ffmpeg
			foot
			gimp
			swaybg
			gnome.adwaita-icon-theme
			grim
			imagemagick
			mpc-cli
			mpd
			mpv
			obs-studio
			river
			slurp
			tofi
			transmission
			wl-clipboard
			yambar
			yt-dlp
		];
	};

	environment.systemPackages = with pkgs; [
		dash
		fd
		fzf
		neovim
		nnn
		p7zip
		ripgrep
		vis
		w3m
	];

	system.stateVersion = "22.11";
}
