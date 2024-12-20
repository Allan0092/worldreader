import "package:flutter/material.dart";

showBottomSnackBar({
  required BuildContext context,
  required String message,
  int? durationSeconds,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color ?? Colors.green,
    duration: Duration(seconds: durationSeconds ?? 1),
    behavior: SnackBarBehavior.floating,
  ));
}
