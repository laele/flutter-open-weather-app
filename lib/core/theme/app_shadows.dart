import 'package:flutter/material.dart';

abstract final class AppShadows {
  static final weatherCard = [
    BoxShadow(
      color: const Color.fromARGB(255, 0, 99, 220).withAlpha(255),
      spreadRadius: 0,
      blurRadius: 40,
      offset: const Offset(0, 0),
    ),
  ];
}
