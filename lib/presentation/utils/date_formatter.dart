import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String dateFromat() {
  DateTime currentTime = DateTime.now();
  String formattedDate =
      DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(currentTime);

  return formattedDate;
}

String formatTanggal(DateTime tanggal) {
  String tanggalString = DateFormat('yyyy-MM-dd').format(tanggal);
  return tanggalString;
}

int getJumlahTanggal() {
  String formattedDate = DateFormat('yyyy-MM').format(DateTime.now());
  DateTime parsedDate = DateFormat('yyyy-MM').parse(formattedDate);
  int numberOfDays = DateTime(parsedDate.year, parsedDate.month + 1, 0).day;
  return numberOfDays;
}

List<String> getDaysOfMonth(int month) {
  List<String> daysList = [];

  initializeDateFormatting('id_ID', null);

  DateTime now = DateTime.now();
  DateTime firstDayOfMonth = DateTime(now.year, month, 1);
  int numberOfDaysInMonth = DateTime(now.year, month + 1, 0).day;

  for (int i = 0; i < numberOfDaysInMonth; i++) {
    DateTime nextDate = firstDayOfMonth.add(Duration(days: i));
    String formattedDay = DateFormat('EEEE', 'id_ID').format(nextDate);
    daysList.add(formattedDay);
  }

  return daysList;
}

String getFormattedDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd MMMM yyyy').format(now);
  return formattedDate;
}

String getFormattedDateNow() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  return formattedDate;
}

String formatTime(String time) {
  List<String> components = time.split(':');
  int hour = int.parse(components[0]);
  int minute = int.parse(components[1]);
  // Ubah jam menjadi format 12 jam
  if (hour >= 12) {
    hour = hour - 12;
  }
  if (hour == 0) {
    hour = 12;
  }

  String formattedHour = hour.toString().padLeft(2, '0');
  String formattedMinute = minute.toString().padLeft(2, '0');

  return '$formattedHour.$formattedMinute';
}

String formatDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateFormat dateFormat = DateFormat('EEEE, d MMMM', 'id_ID');
  String formattedDate = dateFormat.format(dateTime);
  return formattedDate;
}

int getCurrentDate() {
  DateTime now = DateTime.now().toUtc().add(const Duration(hours: 8));
  String formattedDate = DateFormat('dd').format(now);
  return int.parse(formattedDate);
}

String getFormattedMonth() {
  final currentTime = DateTime.now().toUtc().add(const Duration(hours: 8));
  final formatter = DateFormat.MMMM('id_ID');
  final formattedMonth = formatter.format(currentTime);
  return formattedMonth;
}

String getMonthNow() {
  final currentTime = DateTime.now().toUtc().add(const Duration(hours: 8));
  final formatter = DateFormat.M('id_ID');
  final formattedMonth = formatter.format(currentTime);
  return formattedMonth;
}
