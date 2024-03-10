enum PokemonType {
  bug,
  dark,
  dragon,
  electric,
  fire,
  grass,
  fairy,
  fighting,
  flying,
  ghost,
  ground,
  ice,
  normal,
  poison,
  psychic,
  rock,
  steel,
  water,
}

enum PokemonGender {
  male,
  maleOnly,
  female,
  femaleOnly,
  genderless,
  undefinied,
}

enum PokemonVariant {
  normal,
  shiny,
}

enum PokeballType {
  undefined,
  pokeball,
  greatBall,
  ultraBall,
  masterBall,
  premierball,
  duskball,
  quickball,
  luxuryball,
  repeatball,
  timerball,
  netball,
  nestball,
  diveball,
  heavyball,
  levelball,
  loveball,
  moonball,
  lureball,
  dreamball,
  healball,
  friendball,
  fastball,
  sportball,
  safariball,
  beastball,
  hisuipokeball,
  hisuigreatball,
  hisuiultraball,
  hisuifeatherball,
  hisuiwingball,
  hisuijetball,
  hisuiheavyball,
  hisuileadenball,
  hisuigigatonball,
  originball,
  strangeball,
  parkball,
  cherishball,
}

enum PokemonAttributes {
  isShiny,
  isAlpha,
}

enum ScreenType { pokedex, tracker, collection }

enum FilterType {
  captured,
  notCaptured,
  all,
  exclusiveOnly,
  byValue,
  byType,
  nameAsc,
  nameDesc,
  numAsc,
  numDesc
}

enum CollectionDisplayType {
  flatList,
  groupByCurrentGame,
  groupByOriginalGame,
  groupByPokemon
}

enum CaptureType { full, partial, empty }

enum CaptureMethod { wild, raid, egg, trade, event, unknown }

enum DetailsLock {
  ball,
  ability,
  level,
  gender,
  captureDate,
  originalTrainer,
  capturedMethod,
  gameOrigin,
  gameCurrently,
  attributes,
  attributesShiny,
  attributesMega,
  attributesDina,
  attributesAlpha,
}
