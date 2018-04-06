with import <nixpkgs> {};

# nix-build wee-grep.nix
# cp -vif result/grep.py ~/.weechat/python/autoload
let
  env = buildEnv {
    name = "deps";
    paths = [ python27Packages.six ];
  };
in stdenv.mkDerivation {
  name = "wee-grep";
  src = fetchFromGitHub {
    owner = "weechat";
    repo = "scripts";
    rev = "ed6d0c0613b58197d913d0358e2db60315971d62";
    sha256 = "1db556amkcb1qgccmswf4ba6h2pvfyyxd5xw1hm50dvxwgznrnq8";
  };
  SUBST_VAR = "${env}/lib/python2.7/site-packages";
  installPhase = ''
    mkdir $out
    substitute ./python/grep.py $out/grep.py --subst-var SUBST_VAR
  '';
}
