{ pkgs, lib, config, inputs, ... }:

{
  packages = [ 
    pkgs.git
    pkgs.kind
    pkgs.kubectl
    #pkgs.kubernetes-helm
    pkgs.helmfile
    (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [ pkgs.kubernetes-helmPlugins.helm-diff ]; })
  ];

  languages.nix.enable = true;

  scripts.start.exec = ''
    docker start kind-control-plane kind-worker kind-worker2
  '';

  scripts.stop.exec = ''
    docker stop kind-control-plane kind-worker kind-worker2
  '';
}
