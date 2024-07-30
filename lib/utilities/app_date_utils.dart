import 'package:intl/intl.dart';

class AppDateUtils {
  static String parseInputDate(String dateString) {
    var inputFormat = DateFormat("dd/MM/yyyy");
    var outputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    var inputDate = inputFormat.parse(dateString);

    return outputFormat.parse(inputDate.toString()).toString();
  }

  static String formatDate(String dateString) {
    var outputFormat = DateFormat("dd/MM/yyyy");
    var inputFormat = DateFormat("yyyy-MM-dd HH:mm.SSS");

    var inputDate = inputFormat.parse(dateString);

    return outputFormat.parse(inputDate.toString()).toString();
  }
}
