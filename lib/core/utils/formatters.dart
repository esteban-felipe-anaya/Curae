import 'package:intl/intl.dart';

/// Centralised date/time/currency formatting. Never format dates/money by hand.
class Fmt {
  Fmt._();

  static DateTime? _parse(String iso) => DateTime.tryParse(iso);

  /// "Mon, 16 Jun"
  static String dayMonth(String iso) {
    final d = _parse(iso);
    return d == null ? iso : DateFormat('EEE, d MMM').format(d);
  }

  /// "16 June 2026"
  static String fullDate(String iso) {
    final d = _parse(iso);
    return d == null ? iso : DateFormat('d MMMM yyyy').format(d);
  }

  /// "Jun 2026"
  static String monthYear(String iso) {
    final d = _parse(iso);
    return d == null ? iso : DateFormat('MMM yyyy').format(d);
  }

  /// Friendly relative-ish label used on cards: Today / Tomorrow / weekday.
  static String relativeDay(String iso) {
    final d = _parse(iso);
    if (d == null) return iso;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final that = DateTime(d.year, d.month, d.day);
    final diff = that.difference(today).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff == -1) return 'Yesterday';
    return DateFormat('EEE, d MMM').format(d);
  }

  /// "09:00" 24h string -> localized time "9:00 AM".
  static String time(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length != 2) return hhmm;
    final h = int.tryParse(parts[0]) ?? 0;
    final m = int.tryParse(parts[1]) ?? 0;
    final dt = DateTime(2000, 1, 1, h, m);
    return DateFormat.jm().format(dt);
  }

  static String money(num amount, String currency) {
    final symbol = switch (currency.toUpperCase()) {
      'USD' => '\$',
      'MXN' => '\$',
      'EUR' => '€',
      _ => '$currency ',
    };
    final f = NumberFormat.currency(symbol: symbol, decimalDigits: amount % 1 == 0 ? 0 : 2);
    return f.format(amount);
  }

  /// Age in whole years from an ISO date of birth.
  static int? ageFromDob(String iso) {
    final d = _parse(iso);
    if (d == null) return null;
    final now = DateTime.now();
    var age = now.year - d.year;
    if (now.month < d.month || (now.month == d.month && now.day < d.day)) age--;
    return age;
  }
}
