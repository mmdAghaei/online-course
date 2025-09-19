import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:podcast/core/constants/fonts.dart';
import 'package:podcast/main.dart';

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
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffF5F7FB),
      foregroundColor: Color(0xff272323), // رنگ متن AppBar
      elevation: 0,
    ),
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
      primary: Color(0xff0F172A), // نگه‌داشتن هویت برند
      secondary: Color(0xFF9E9E9E),
      background: Color(0xFF121212), // استاندارد متریال
    ),
    scaffoldBackgroundColor: const Color(0xff121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff121212),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    extensions: const [
      CustomColors(
        navibox: Color(0xff1E1E1E),
        iconnavi: Color(0xffFFFFFF),
        colorText: Color(0xffF5F5F5),
        card: Color(0xFF1E1E1E),
        title: Color(0xffFFFFFF),
        stateBox: Color(0xff0F172A),
        stateText: Colors.white,
        price: Color(0xffE0E0E0),
        priceoff: Color(0xff9E9E9E),
        desc: Color(0xffA6A6A6),
        blueCard: Color(0xff224AA9),
      ),
    ],
  );
}

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
