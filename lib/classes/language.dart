import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: constant_identifier_names
const String LAGUAGE_CODE = 'languageCode';
// ignore: constant_identifier_names
const String ENGLISH = 'en';
// ignore: constant_identifier_names
const String VIETNAMESE = 'vi';
//! Method Locale nhận vào languageCode => kết quả trả vè là kiểu Locale
Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case VIETNAMESE:
      return const Locale(VIETNAMESE, '');
    default:
      return const Locale(VIETNAMESE, '');
  }
}
//! Dựa vào đầu và là LanguageCode (String) trả về kiểu Locale
Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}
//! Nếu Tải App lần đầu thì language sau khi getLocale sẽ là Null => mặc định là  Vietnamese
Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LAGUAGE_CODE) ?? VIETNAMESE;
  return _locale(languageCode);
}
//! Hàm để đổi ngôn ngữ từng Text
AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
