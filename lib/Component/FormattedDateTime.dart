import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final formattedDate =
      DateFormat('EEEE, dd MMMM yyyy', 'en_US').format(dateTime);
  return formattedDate;
}
