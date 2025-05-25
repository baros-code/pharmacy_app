import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formatDefault({
    bool includeTime = false,
    bool commaSeparator = false,
  }) =>
      includeTime
          ? commaSeparator
              ? DateFormat('dd/MM/yyyy, HH:mm').format(this)
              : DateFormat('dd/MM/yyyy - HH:mm').format(this)
          : DateFormat('dd/MM/yyyy').format(this);
}
