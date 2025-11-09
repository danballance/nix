{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    git
    gptfdisk
    lazygit
		lazyjournal
		lazysql
    lsd
		lsof
    nh
    nmon
    parted
    procs
    ripgrep
		systemctl-tui
    tree
		unzip
    vim
    wget
		#wireplumber
    yazi
  ];
}
