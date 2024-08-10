import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class LanguageChangeProvider with ChangeNotifier {
  late Locale _currentLocale;

  Locale get currentLocale => _currentLocale;

  static const SupportedLocales = [
    Locale('en'), // English
    Locale('es'), // Spanish
    Locale('fr'), // Spanish
  ];



  LanguageChangeProvider() {
    _currentLocale = getLocaleFromLocaleName(Platform.localeName);
    debugPrint(
        "LanguageChangeProvider:initialize: _currentLocale: ${Platform.localeName}  $_currentLocale");
    notifyListeners();
  }

  Locale getLocaleFromLocaleName(String localeName) {
    Locale _locale;
    final parts = localeName.split('_');
    if (parts.length >= 1) {
      _locale = Locale(parts[0]);
    } else {
      _locale = Locale("en");
    }
    return _locale;
  }

   changeLocale(String _locale) {
    this._currentLocale = Locale(_locale);
    debugPrint(
        "LanguageChangeProvider:initialize: _currentLocale: ${Platform.localeName}  $_currentLocale");
    notifyListeners();
  }
}
