import 'package:intl/intl.dart';

class StringUtils {
  StringUtils._();

  static bool isEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  static bool isNotEmpty(String? str) {
    return str != null && str.isNotEmpty;
  }

  static bool isBlank(String? str) {
    return str == null || str.trim().isEmpty;
  }

  static bool isNotBlank(String? str) {
    return str != null && str.trim().isNotEmpty;
  }

  static String capitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }

  static String capitalizeWords(String str) {
    return str.split(' ').map((word) => capitalize(word)).join(' ');
  }

  static String toUpperCase(String str) {
    return str.toUpperCase();
  }

  static String toLowerCase(String str) {
    return str.toLowerCase();
  }

  static String reverse(String str) {
    return str.split('').reversed.join('');
  }

  static String truncate(String str, int maxLength, {String ellipsis = '...'}) {
    if (str.length <= maxLength) return str;
    return str.substring(0, maxLength - ellipsis.length) + ellipsis;
  }

  static String replace(String str, String from, String to) {
    return str.replaceAll(from, to);
  }

  static String replaceFirst(String str, String from, String to) {
    return str.replaceFirst(from, to);
  }

  static List<String> split(String str, String separator) {
    return str.split(separator);
  }

  static String join(List<String> list, String separator) {
    return list.join(separator);
  }

  static bool startsWith(String str, String prefix) {
    return str.startsWith(prefix);
  }

  static bool endsWith(String str, String suffix) {
    return str.endsWith(suffix);
  }

  static bool contains(String str, String substring) {
    return str.contains(substring);
  }

  static bool containsIgnoreCase(String str, String substring) {
    return str.toLowerCase().contains(substring.toLowerCase());
  }

  static int indexOf(String str, String substring) {
    return str.indexOf(substring);
  }

  static int lastIndexOf(String str, String substring) {
    return str.lastIndexOf(substring);
  }

  static String substring(String str, int start, [int? end]) {
    return str.substring(start, end);
  }

  static String trim(String str) {
    return str.trim();
  }

  static bool equals(String str1, String str2) {
    return str1 == str2;
  }

  static bool equalsIgnoreCase(String str1, String str2) {
    return str1.toLowerCase() == str2.toLowerCase();
  }

  static List<String> toCharList(String str) {
    return str.split('');
  }

  static String fromCharList(List<String> chars) {
    return chars.join('');
  }

  static bool isNumeric(String str) {
    if (str.isEmpty) return false;
    return num.tryParse(str) != null;
  }

  static bool isAlphaNumeric(String str) {
    if (str.isEmpty) return false;
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(str);
  }

  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  static String formatCurrency(
    double amount, {
    String symbol = '\$',
    String locale = 'en_US',
  }) {
    return NumberFormat.currency(symbol: symbol, locale: locale).format(amount);
  }

  static bool isUrl(String str) {
    return RegExp(r'^https?://').hasMatch(str);
  }

  static bool isPhoneNumber(String str) {
    String digits = str.replaceAll(RegExp(r'[^\d]'), '');
    return digits.length >= 10;
  }

  static String removeSpecialChars(String str) {
    return str.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  static String removeNumbers(String str) {
    return str.replaceAll(RegExp(r'[0-9]'), '');
  }

  static String removeLetters(String str) {
    return str.replaceAll(RegExp(r'[a-zA-Z]'), '');
  }

  static String removeWhitespace(String str) {
    return str.replaceAll(RegExp(r'\s+'), '');
  }

  static String normalizeWhitespace(String str) {
    return str.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static String toCamelCase(String str) {
    List<String> words = str.split(RegExp(r'[-_\s]+'));
    String result = words[0].toLowerCase();
    for (int i = 1; i < words.length; i++) {
      result += capitalize(words[i].toLowerCase());
    }
    return result;
  }

  static String toSnakeCase(String str) {
    return str
        .replaceAll(RegExp(r'([A-Z])'), '_1')
        .toLowerCase()
        .replaceAll(RegExp(r'-|_'), '_');
  }

  static String toPascalCase(String str) {
    List<String> words = str.split(RegExp(r'[-_\s]+'));
    return words.map((word) => capitalize(word.toLowerCase())).join('');
  }

  static String toBase64(String str) {
    return Uri.encodeComponent(str);
  }

  static String fromBase64(String str) {
    return Uri.decodeComponent(str);
  }
}
