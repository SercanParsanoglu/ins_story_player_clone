//! VİDEO 11

import 'package:flutter/material.dart';
import 'package:stories_app/product/constants/color.dart';

class CustomTheme {
  ThemeData theme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: ProjectColor.athensGrey,
      appBarTheme: AppBarTheme(
          shadowColor: ProjectColor.athensGrey,
          backgroundColor: ProjectColor.athensGrey,
          titleTextStyle: TextStyle(
              color: ProjectColor.blackPearl,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
          centerTitle: true),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              color: ProjectColor.athensGrey,
              fontSize: 12,
              fontWeight: FontWeight.bold)));
}
