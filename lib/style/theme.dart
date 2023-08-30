import 'package:flutter/material.dart';

ThemeData themeData(BuildContext context) => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFBFBF)),
    primaryColor: const Color(0xFFFFBFBF),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      centerTitle: false,
    ),
    cardTheme: const CardTheme(
        surfaceTintColor: Color(0x00000000), color: Colors.white),
    bottomSheetTheme: const BottomSheetThemeData(showDragHandle: true),
    dividerTheme: DividerThemeData(color: Theme.of(context).focusColor));
