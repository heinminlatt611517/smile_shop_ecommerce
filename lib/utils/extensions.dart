import 'package:intl/intl.dart';

extension StringExtension on String {
  String get toCapitalized => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' ');
}

extension FormatTime on DateTime {
  String format({String? formatType}) {
    final DateFormat formatter = DateFormat(formatType ?? 'dd MMM, yyyy | hh:mm a');
    final String formatted = formatter.format(this);
    return formatted;
  }
}