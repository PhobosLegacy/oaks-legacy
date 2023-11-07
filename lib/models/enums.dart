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
  female,
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
  cherishball,
  quickball,
  beastball,
  luxuryball,
  repeatball,
  timerball,
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
