// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final double yuzde;
  const ProgressBar({
    required this.yuzde,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 3,
      percent: yuzde,
      progressColor: Colors.white,
      backgroundColor: Colors.blueGrey.shade700,
    );
  }
}
