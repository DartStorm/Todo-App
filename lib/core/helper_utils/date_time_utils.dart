import 'package:intl/intl.dart';

String formatedDate(DateTime? dateTime) {
  if (dateTime != null) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  } else {
    return "";
  }
}
