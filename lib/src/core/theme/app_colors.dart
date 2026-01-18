import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFE10600);
  static const Color primary500 = Color(0xFFD64E2D);
  static const Color primary100 = Color(0xFFFFF3F0);

  static const Color secondaryOrange = Color(0xFFFA4616);
  static const Color secondaryPink = Color(0xFFE0004D);

  static const Color secondary100 = Color(0xFFF1F4FE);
  static const Color secondary500 = Color(0xFF344D99);
  static const Color secondary600 = Color(0xFF273972);

  static const Color ink1 = Color(0xFF222222);
  static const Color ink2 = Color(0xFF363636);
  static const Color ink3 = Color(0xFF545454);
  static const Color ink6 = Color(0xFFD3D3D3);

  static Gradient primaryGradient = LinearGradient(
    colors: [
      primaryColor,
      secondaryOrange,
      secondaryPink,
    ],
  );

  static Gradient linear9 = LinearGradient(
    colors: [
      Color(0xFFFF501F),
      Color(0xFFFF9168),
    ],
  );

  static const Color bg200 = Color(0xFFF7F8F9);
  static const Color bg300 = Color(0xFFF3F5F9);
  static const Color bg400 = Color(0xFFEBEEF2);
  static const Color bg500 = Color(0xFFE5E9EE);

  static const Color text100 = Color(0xFFC2CFD7);
  static const Color text200 = Color(0xFF7090A4);
  static const Color text300 = Color(0xFF325B75);
  static const Color text400 = Color(0xFF083D5E);
  static const Color text500 = Color(0xFF062E46);

  static const Color error500 = Color(0xFFE73232);

  static const Color info100 = Color(0xFFE5F0FF);
  static const Color info500 = Color(0xFF1365DF);

  static const Color sematicRed = Color(0xFFC53916);
  static const Color red3 = Color(0xFFFF4E49);
  static const Color red8 = Color(0xFFFFCCCB);

  static const Color pink8 = Color(0xFFFFA1C1);
  static const Color pink9 = Color(0xFFFFC4D9);
}
