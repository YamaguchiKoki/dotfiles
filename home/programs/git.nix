{ pkgs, ... }: {
  programs.git = {
    enable = true;

    userName = "YamaguchiKoki";
    userEmail = "shankouhanghui15@gmail.com";

    delta.enable = true;

    ignores = [
      ".DS_Store"
      "node_modules/"
      "bower_components/"
      ".idea/"
      "*.iml"
      ".vscode/"
    ];

    extraConfig = {
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
}
