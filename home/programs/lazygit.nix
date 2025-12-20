{ ... }: {
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          command = "/etc/profiles/per-user/kokiyamaguchi/bin/git-cz";
          context = "files";
          key = "c";
          output = "terminal";
        }
      ];
      gui = {
        language = "ja";
        showIcons = true;
      };
      git = {
        branchLogCmd = "git log --graph --color=always --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' {{branchName}} --";
        pagers = [
          {
            name = "main";
            colorArg = "always";
            pager = "delta --dark --paging=never";
          }
        ];
        allBranchesLogCmds = [
          "git log --graph --color=always --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
        ];
      };
    };
  };
}
