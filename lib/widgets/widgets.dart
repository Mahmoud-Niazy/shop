import 'package:flutter/material.dart';

TextWith2Lan(
    {required bool enLan, required String ar, required String en, required,  TextStyle? style}
) {
  if (enLan) {
    return Text(
      en,
    style: style,
    );
  }
  if (!enLan) {
    return Text(
    ar,
    style: style,
    );
  }
}
