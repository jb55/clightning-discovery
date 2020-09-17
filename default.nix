{ nixpkgs ? import (fetchTarball "https://github.com/jb55/nixpkgs/archive/40e259d9aae94de2836af7ef5596a6047637dcb3.tar.gz") {} 
}:
let
  pkgs = nixpkgs.pkgsMusl;
  dbus = pkgs.dbus.override { withStatic = true; };
  avahi = pkgs.avahi.override { withStatic = true; };
in
with pkgs;
stdenv.mkDerivation {
  pname = "clightning-discover";
  version = "0.1";
  nativeBuildInputs = [ pkg-config ]; 
  buildInputs = [ avahi dbus ];
}
