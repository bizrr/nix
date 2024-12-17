{ ... }: {
  programs.git = {
    enable = true;
    userName = "Roy Långsjö";
    userEmail = "roylangsjo@gmail.com";

    aliases = {
      co = "checkout";
    };

    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      pull.rebase = true;
    };
	
  };
}
