import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('ru'),
    const Locale('kk'),
    const Locale('en'),
    const Locale('de'),
    const Locale('fr'),
  ];

  static String getCountryName(String code) {
    switch (code) {
      case "kk":
        return "Kazakhstan";
      case "ru":
        return "Russia";
      case "en":
        return "England";
      case "de":
        return "Germany";
      case "fr":
        return "France";
      default:
        return "yes";
    }
  }
}
