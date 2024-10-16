// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF1A1F24);
  static const Color secoundaryBackground = Color(0xFF000000);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secoundaryText = Color(0xFF8B97A2);
  static const Color thirdText = Color(0xFFB4FFFFF);
  static const Color primaryGreen = Color(0xFF39D2C0);
  static const Color primaryRed = Color.fromARGB(255, 255, 0, 51);
  static const Color secoundaryRed = Color(0xFFF2A384);
  static const Color secundaryGreen = Color(0xFF00968A);
  static const Color secondaryRed = Color(0x4DD23939);

  static const LinearGradient background3D = LinearGradient(
    colors: [
      Color(0xFF1A1F24),
      Color(0xFF232A31),
      Color(0xFF14191D),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient primaryGreen3D = LinearGradient(
    colors: [
      Color(0xFF39D2C0),
      Color(0xFF33C1B1),
      Color(0xFF2EAA9C),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.7, 1.0],
  );

  static const LinearGradient secondaryRed3D = LinearGradient(
    colors: [
      Color(0xFFF2A384),
      Color.fromARGB(
          255, 213, 142, 114),
      Color.fromARGB(255, 181, 122, 99),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.7, 1.0],
  );
}
