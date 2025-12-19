import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm:ss';
  static const String isoFormat = 'yyyy-MM-ddTHH:mm:ss.SSSZ';

  static DateTime now() => DateTime.now();

  static DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static String formatDate(DateTime date, {String format = dateFormat}) {
    return DateFormat(format).format(date);
  }

  static String formatTime(DateTime dateTime, {String format = timeFormat}) {
    return DateFormat(format).format(dateTime);
  }

  static String formatDateTime(
    DateTime dateTime, {
    String format = dateTimeFormat,
  }) {
    return DateFormat(format).format(dateTime);
  }

  static String formatReadable(DateTime date, {String locale = 'it_IT'}) {
    return DateFormat('EEEE d MMMM yyyy', locale).format(date);
  }

  static String formatCompact(DateTime date, {String locale = 'it_IT'}) {
    return DateFormat('d MMM yyyy', locale).format(date);
  }

  static String formatMonthYear(DateTime date, {String locale = 'it_IT'}) {
    return DateFormat('MMMM yyyy', locale).format(date);
  }

  static String formatDayOfWeek(DateTime date, {String locale = 'it_IT'}) {
    return DateFormat('EEEE', locale).format(date);
  }

  static DateTime? tryParse(
    String dateString, {
    String format = dateTimeFormat,
  }) {
    try {
      return DateFormat(format).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static DateTime parse(String dateString, {String format = dateTimeFormat}) {
    return DateFormat(format).parse(dateString);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool isToday(DateTime date) {
    return isSameDay(date, today());
  }

  static bool isYesterday(DateTime date) {
    return isSameDay(date, today().subtract(Duration(days: 1)));
  }

  static bool isTomorrow(DateTime date) {
    return isSameDay(date, today().add(Duration(days: 1)));
  }

  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  static bool isInYear(DateTime date, int year) {
    return date.year == year;
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inDays;
  }

  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  static DateTime subtractDays(DateTime date, int days) {
    return date.subtract(Duration(days: days));
  }

  static DateTime addMonths(DateTime date, int months) {
    var month = date.month + months;
    var year = date.year;
    while (month > 12) {
      month -= 12;
      year++;
    }
    while (month <= 0) {
      month += 12;
      year--;
    }
    final day = _getLastDayOfMonth(year, month);
    return DateTime(year, month, date.day > day ? day : date.day);
  }

  static DateTime subtractMonths(DateTime date, int months) {
    return addMonths(date, -months);
  }

  static DateTime addYears(DateTime date, int years) {
    return DateTime(date.year + years, date.month, date.day);
  }

  static int daysInMonth(int year, int month) {
    return _getLastDayOfMonth(year, month);
  }

  static DateTime firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime lastDayOfMonth(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      _getLastDayOfMonth(date.year, date.month),
    );
  }

  static DateTime firstDayOfWeek(DateTime date) {
    final diff = date.weekday - DateTime.monday;
    return date.subtract(Duration(days: diff));
  }

  static DateTime lastDayOfWeek(DateTime date) {
    final diff = DateTime.sunday - date.weekday;
    return date.add(Duration(days: diff));
  }

  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  static int getAge(DateTime birthDate) {
    final today = DateTime.now();
    var age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static String timeUntil(DateTime date, {String locale = 'it_IT'}) {
    final now = DateTime.now();
    final diff = date.difference(now);

    if (diff.isNegative) {
      return _formatTimeDiff(diff.abs(), locale, past: true);
    } else {
      return _formatTimeDiff(diff, locale, past: false);
    }
  }

  static int getUnixTimestamp(DateTime date) {
    return date.millisecondsSinceEpoch ~/ 1000;
  }

  static DateTime fromUnixTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  static int _getLastDayOfMonth(int year, int month) {
    if (month == 12) {
      return DateTime(year + 1, 1, 0).day;
    }
    return DateTime(year, month + 1, 0).day;
  }

  static String _formatTimeDiff(
    Duration duration,
    String locale, {
    required bool past,
  }) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);

    if (days > 0) {
      return past ? '$days days ago' : 'in $days days';
    } else if (hours > 0) {
      return past ? '$hours hours ago' : 'in $hours hours';
    } else if (minutes > 0) {
      return past ? '$minutes minutes ago' : 'in $minutes minutes';
    }
    return past ? 'just now' : 'soon';
  }
}
