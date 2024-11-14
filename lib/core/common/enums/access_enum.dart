enum AccessType { private, public, unpublished }

extension AccessTypeConverter on AccessType {
  bool get isPrivateOrPublic => [
        AccessType.private,
        AccessType.public,
      ].contains(this);
  bool get isUnpublished => AccessType.unpublished == this;
  String get asString {
    switch (this) {
      case AccessType.public:
        return "Public";
      default:
        return "Private";
    }
  }

  int get asInt {
    switch (this) {
      case AccessType.private:
        return 1;
      case AccessType.public:
        return 2;
      default:
        return 0;
    }
  }

  static AccessType fromInt(int access) {
    switch (access) {
      case 1:
        return AccessType.private;
      case 2:
        return AccessType.public;
      default:
        return AccessType.unpublished;
    }
  }
}
