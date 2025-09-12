import 'package:flutter/material.dart';
import 'package:podcast/core/constants/fonts.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: Fonts.Vazir.fontFamily,
    colorScheme: const ColorScheme.light(
      primary: Color(0xff0F172A),
      secondary: Color(0xFFC2C2C2),
      background: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xffF5F7FB),
    appBarTheme: const AppBarTheme(color: Color(0xffF5F7FB)),

    extensions: const [
      CustomColors(
        navibox: Color(0xffFFFFFF),
        iconnavi: Color(0xff3B4146),
        colorText: Color(0xFF272323),
        card: Colors.white,
        title: Color(0xff272323),
        stateBox: Color(0xff0F172A),
        stateText: Colors.white,
        price: Color(0xff212121),
        priceoff: Color(0xff646464),
        desc: Color(0xffC7C7C7),
        blueCard: Color(0xff0F172A),
      ),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: Fonts.Vazir.fontFamily,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xff013C4A),
      secondary: Color(0xFF828282),
      background: Color(0xFF1B1B1B),
    ),
    scaffoldBackgroundColor: const Color(0xff1B1B1B),
    appBarTheme: const AppBarTheme(color: Color(0xff1B1B1B)),

    extensions: const [
      CustomColors(
        colorText: Color.fromARGB(255, 253, 253, 253),
        card: Color(0xFF3B3B3B),
        navibox: Color(0xff006B84),
        title: Color(0xffFFFFFF),
        stateBox: Color(0xff0F172A),
        iconnavi: Color(0xffFFFFFF),
        stateText: Colors.white,
        price: Color(0xffD0D0D0),
        priceoff: Color(0xff9E9E9E),
        desc: Color(0xffA6A6A6),
        blueCard: Color(0xff224AA9),
      ),
    ],
  );
}

//  Theme.of(context).extension<CustomColors>()!.colorText,

//white
Color blueCardAboutWhite = Color(0xff0F172A);

//dark
Color blueCardAboutBlack = Color(0xff224AA9);

class CustomColors extends ThemeExtension<CustomColors> {
  final Color? navibox;
  final Color? blueCard;
  final Color? iconnavi;
  final Color? colorText;
  final Color? card;
  final Color? title;
  final Color? stateBox;
  final Color? stateText;
  final Color? desc;
  final Color? price;
  final Color? priceoff;

  const CustomColors({
    this.navibox,
    this.iconnavi,
    this.blueCard,
    this.colorText,
    this.card,
    this.title,
    this.stateBox,
    this.stateText,
    this.desc,
    this.price,
    this.priceoff,
  });

  @override
  CustomColors copyWith({
    Color? navibox,
    Color? iconnavi,
    Color? blueCard,
    Color? colorText,
    Color? card,
    Color? title,
    Color? stateBox,
    Color? stateText,
    Color? desc,
    Color? price,
    Color? priceoff,
  }) {
    return CustomColors(
      blueCard: blueCard ?? this.blueCard,
      navibox: navibox ?? this.navibox,
      iconnavi: iconnavi ?? this.iconnavi,
      colorText: colorText ?? this.colorText,
      card: card ?? this.card,
      title: title ?? this.title,
      stateBox: stateBox ?? this.stateBox,
      stateText: stateText ?? this.stateText,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      priceoff: priceoff ?? this.priceoff,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;

    return CustomColors(
      blueCard: Color.lerp(blueCard, other.blueCard, t),
      navibox: Color.lerp(navibox, other.navibox, t),
      iconnavi: Color.lerp(iconnavi, other.iconnavi, t),
      colorText: Color.lerp(colorText, other.colorText, t),
      card: Color.lerp(card, other.card, t),
      title: Color.lerp(title, other.title, t),
      stateBox: Color.lerp(stateBox, other.stateBox, t),
      stateText: Color.lerp(stateText, other.stateText, t),
      desc: Color.lerp(desc, other.desc, t),
      price: Color.lerp(price, other.price, t),
      priceoff: Color.lerp(priceoff, other.priceoff, t),
    );
  }
}
