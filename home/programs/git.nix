{ pkgs, ... }: {
  programs.git = {
    enable = true;

    ignores = [
      ".DS_Store"
      "node_modules/"
      "bower_components/"
      ".idea/"
      "*.iml"
      ".vscode/"
    ];

    settings = {
      user = {
        name = "YamaguchiKoki";
        email = "shankouhanghiu15@gmail.com";
      };

      core = {
        quotepath = false;
      };

      credential."https://github.com" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };

      credential."https://gist.github.com" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };

      ghq = {
        root = "/Users/kokiyamaguchi/Documents/projects/git";
      };

      merge = {
        tool = "nvimdiff";
      };

      mergetool = {
        prompt = false;
      };

      "mergetool \"nvimdiff\"" = {
        cmd = "nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
      };

      diff = {
        tool = "nvimdiff";
      };

      difftool = {
        prompt = false;
      };

      "difftool \"nvimdiff\"" = {
        cmd = "nvim -d $LOCAL $REMOTE";
      };
    };
  };

  # Delta pager configuration
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
