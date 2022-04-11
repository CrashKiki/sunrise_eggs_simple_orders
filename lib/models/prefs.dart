import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const _prefAccountCode = '_prefAccountCode';
  static const _prefNumber = '_prefNumber';
  static const _prefVisibleItems = '_prefVisibleItems';

  static late SharedPreferences _prefs;

  Prefs._();

  static Future<bool> initialise() async {
    _prefs = await SharedPreferences.getInstance();
    return true;
  }

  static String get accountCode => _prefs.getString(_prefAccountCode) ?? '';
  static set accountCode(String code) =>
      _prefs.setString(_prefAccountCode, code.toUpperCase());

  static String get number => _prefs.getString(_prefNumber) ?? '';
  static set number(String code) => _prefs.setString(_prefNumber, code);

  // '30 Open Case#SM30OC^SL30OC^SXL30OC'
  static List<String> get visibleItems =>
      _prefs.getStringList(_prefVisibleItems) ??
      ['30 Open Case^SM30OC^SL30OC^SXL30OC'];
  static set visibleItems(List<String> items) =>
      _prefs.setStringList(_prefVisibleItems, items);
}
