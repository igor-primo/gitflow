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

  scripts.gp.exec = ''kubectl -n $1 get pods'';
  scripts.gap.exec = ''kubectl get pods -A'';
  scripts.li.exec = ''kubectl -n $1 logs -f $2'';

  scripts.start.exec = ''
    docker start kind-control-plane kind-worker kind-worker2
  '';

  scripts.stop.exec = ''
    docker stop kind-control-plane kind-worker kind-worker2
  '';
}
