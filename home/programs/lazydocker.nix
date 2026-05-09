{ ... }: {
  programs.lazydocker = {
    enable = true;
    settings = {
      gui = {
        showAllContainers = true;
      };
    };
  };
}
