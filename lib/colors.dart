import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE3E3E7),
  100: Color(0xFFB8BAC4),
  200: Color(0xFF898C9D),
  300: Color(0xFF5A5E75),
  400: Color(0xFF363C58),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF111634),
  700: Color(0xFF0E122C),
  800: Color(0xFF0B0E25),
  900: Color(0xFF060818),
});
const int _primaryPrimaryValue = 0xFF13193A;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFF5966FF),
  200: Color(_primaryAccentValue),
  400: Color(0xFF0014F2),
  700: Color(0xFF0012D8),
});
const int _primaryAccentValue = 0xFF2638FF;
