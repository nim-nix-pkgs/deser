{
  description = ''De/serialization library for Nim '';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-deser-v0_1_2.flake = false;
  inputs.src-deser-v0_1_2.ref   = "refs/tags/v0.1.2";
  inputs.src-deser-v0_1_2.owner = "gabbhack";
  inputs.src-deser-v0_1_2.repo  = "deser";
  inputs.src-deser-v0_1_2.type  = "github";
  
  inputs."github.com/gabbhack/anycase-fork".owner = "nim-nix-pkgs";
  inputs."github.com/gabbhack/anycase-fork".ref   = "master";
  inputs."github.com/gabbhack/anycase-fork".repo  = "github.com/gabbhack/anycase-fork";
  inputs."github.com/gabbhack/anycase-fork".dir   = "";
  inputs."github.com/gabbhack/anycase-fork".type  = "github";
  inputs."github.com/gabbhack/anycase-fork".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/gabbhack/anycase-fork".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-deser-v0_1_2"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-deser-v0_1_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}