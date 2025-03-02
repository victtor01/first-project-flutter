import 'package:flutter/material.dart';
import 'package:mobile_pointsale/common/constants/app_colors.dart';

class ButtonGradient extends StatelessWidget {
  final String buttonText;
  final double height;
  final double fontSize;
  final VoidCallback onPressed;

  ButtonGradient({
    super.key,
    required this.buttonText, // Texto do botão
    required this.height, // Altura do botão
    required this.fontSize, // Tamanho da fonte
    required this.onPressed, // Função para ser chamada ao clicar
  });

  final Decoration _decoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.indigo600, AppColors.purple600],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      shadowColor: AppColors.indigo600.withOpacity(0.5),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Ink(
        decoration: _decoration,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            height: height,
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
