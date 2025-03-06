import 'package:intl/intl.dart';

extension StringExtension on String {
  String get toCapitalized => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' ');
}

extension FormatTime on DateTime {
  String format({String? formatType}) {
    final DateFormat formatter = DateFormat(formatType ?? 'dd MMM, yyyy | hh:mm a');
    final String formatted = formatter.format(this);
    return formatted;
  }
}

extension NumberFormatting on num {
  String formatWithCommas() {
    final formatter = NumberFormat("#,###");
    return formatter.format(this);
  }
}

extension SplitStringExtension on String {
  String getFirstPart() {
    List<String> words = split(' ');
    if (words.length > 1) {
      return words.sublist(0, words.length - 1).join(' ');
    } else {
      return '';
    }
  }

  String? getFirstWord() {
    return split(' ').first;
  }

  String? getLastWords() {
    List<String> words = split(' ') ?? [];
    if (words.length <= 1) {
      return '';
    }
    return words.sublist(1).join(' ');
  }
}
