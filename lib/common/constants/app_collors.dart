// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF1A1F24);
  static const Color secoundaryBackground = Color(0xFF000000);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secoundaryText = Color(0xFF8B97A2);
  static const Color primaryGreen = Color(0xFF39D2C0);
  static const Color primaryRed = Color.fromARGB(255, 255, 0, 51);
  static const Color secundaryGreen = Color(0xFF00968A);
  static const Color secondaryRed = Color.fromARGB(77, 210, 57, 57);

  static const LinearGradient background3D = LinearGradient(
    colors: [
      Color(0xFF1A1F24), // Cor de fundo principal
      Color(0xFF232A31), // Tom mais claro para criar profundidade
      Color(0xFF14191D), // Tom mais escuro para criar sombra
    ],
    begin: Alignment.topLeft, // Início do degradê
    end: Alignment.bottomRight, // Fim do degradê
    stops: [0.0, 0.5, 1.0], // Posições intermediárias do degradê
  );

  static const LinearGradient primaryGreen3D = LinearGradient(
    colors: [
      Color(0xFF39D2C0), // Cor principal (primaryGreen)
      Color(0xFF33C1B1), // Um tom mais suave (ligeiramente mais escuro)
      Color(0xFF2EAA9C), // Tom mais escuro para profundidade
    ],
    begin: Alignment.topLeft, // Início do degradê
    end: Alignment.bottomRight, // Fim do degradê
    stops: [0.0, 0.7, 1.0], // Posições intermediárias do degradê
  );
}
