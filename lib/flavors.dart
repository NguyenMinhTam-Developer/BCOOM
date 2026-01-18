enum Flavor {
  dev,
  stg,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'PharmaCom Dev';
      case Flavor.stg:
        return 'PharmaCom Staging';
      case Flavor.prod:
        return 'PharmaCom';
      default:
        return 'PharmaCom';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://apibmos.1984s.co';
      case Flavor.stg:
        return 'https://apibmos.1984s.co';
      case Flavor.prod:
        return 'https://apibmos.1984s.co';
      default:
        return 'https://apibmos.1984s.co';
    }
  }

  static bool get isProd => appFlavor == Flavor.prod;
  static bool get isStg => appFlavor == Flavor.stg;
  static bool get isDev => appFlavor == Flavor.dev;
}
