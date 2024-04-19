import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  String period = 'AM';
  int hour = dateTime.hour;
  if (hour >= 12) {
    period = 'PM';
    if (hour > 12) {
      hour -= 12;
    }
  }
  String minute = dateTime.minute.toString().padLeft(2, '0');
  return '$hour:$minute $period';
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('E, d/MM/yy, h:mm a').format(dateTime);
}

void showSnackbar({required String title, required String subtitle, path}) {
  Get.snackbar(
    title,
    subtitle,
    icon: Icon(path, size: 28),
    snackPosition: SnackPosition.BOTTOM,
  );
}
