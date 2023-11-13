import 'package:flutter/material.dart';
import 'package:goggles_of_revealing/ui/constants.dart';

Widget _TrophieCard(String title) {
  return Container(
    decoration: BoxDecoration(color: Constants.primaryColor),
    height: 30,
    width: double.infinity,
    child: Text(title),
  );
}
