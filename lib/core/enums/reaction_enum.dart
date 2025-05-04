enum ReactionType { like, dislike, none }

extension ReactionConverter on ReactionType {
  String get asString {
    switch (this) {
      case ReactionType.like:
        return "Like";
      case ReactionType.dislike:
        return "Dislike";
      case ReactionType.none:
        return "None";
    }
  }

  int get asInt {
    switch (this) {
      case ReactionType.like:
        return 1;
      case ReactionType.dislike:
        return 2;
      default:
        return 0;
    }
  }

  static ReactionType fromInt(int reaction) {
    switch (reaction) {
      case 1:
        return ReactionType.like;
      case 2:
        return ReactionType.dislike;
      default:
        return ReactionType.none;
    }
  }
}
