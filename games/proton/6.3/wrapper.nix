{ gameFiles, game, ... }:

gameFiles.overrideAttrs (_:{
  name = game.name;
})
