import 'package:intl/intl.dart';

String formatDate({required DateTime time, String pattern = "d MMM, yyyy"}) {
  return DateFormat(pattern).format(time);
}
