import 'package:flutter/material.dart';

extension DateTimeExt on DateTime {
  String todmmmyyyy() {
    return '$day ${getShortMonth(month)}, $year';
  }

  String caption() {
    return DateUtils.isSameDay(this, DateTime.now()) ? "Today" : todmmmyyyy();
  }
}

String getShortMonth(int i) {
  switch (i) {
    case 0:
      return "Jan";
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "";
  }
}
