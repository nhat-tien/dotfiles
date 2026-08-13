{ lib }:

let
  collectNixFiles = dir:
    let
      entries = builtins.readDir dir;
      paths = lib.mapAttrsToList
        (name: type:
          let full = dir + "/${name}"; in
          if type == "directory" then collectNixFiles full
          else if lib.hasSuffix ".nix" name then [ full ]
          else []
        )
        entries;
    in
      lib.flatten paths;
in
{
  inherit collectNixFiles;
}
