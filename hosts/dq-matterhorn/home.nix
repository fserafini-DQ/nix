{ pkgs, ... }: {
  home.stateVersion = "24.05";
  home.username = "mrbash";
  # home.homeDirectory = "/Users/mrbash";
  # programs.home-manager.enable = true;
  # programs.ssh.enable = true;
  home.packages = with pkgs; [
    # NOTE: we use colima instead of Docker Desktop as a runtime
    # Ref: https://www.tyler-wright.com/blog/using-colima-on-an-m1-m2-mac/
    # First startup:
    # * `softwareupdate --install-rosetta --agree-to-license`
    # * `colima start --arch aarch64 --vm-type=vz --vz-rosetta`
    colima
    just
    go-task
    direnv
    terraform
    terraform-ls
    awscli2
    minikube
    kubectl
    k9s
    kustomize
  ];

  programs.ssh = {
    enable = true;
    includes = [
      "~/.colima/ssh_config" # NOTE: colima isn't being particularly smart about it.
    ];
  };
}
