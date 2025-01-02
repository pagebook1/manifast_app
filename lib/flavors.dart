enum Flavor {
  dev,
  staging,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Manifast Dev';
      case Flavor.staging:
        return 'Manifast';
      default:
        return 'title';
    }
  }

}
