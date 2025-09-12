enum Fonts { Vazir, VazirMedium, VazirBold, VazirBlack, ExtraBold }

extension AppFontsExtension on Fonts {
  String get fontFamily {
    switch (this) {
      case Fonts.Vazir:
        return 'Vazir';
      case Fonts.VazirMedium:
        return 'VazirMedium';
      case Fonts.VazirBold:
        return 'VazirBold';
      case Fonts.VazirBlack:
        return 'VazirBlack';
      case Fonts.ExtraBold:
        return 'ExtraBold';
    }
  }
}
