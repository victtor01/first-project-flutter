import 'package:flutter/material.dart';
import 'package:test/common/constants/app_colors.dart';

class CustomLink extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final Widget Function() destination;

  const CustomLink({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.destination,
  });

  void _navigateTo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _navigateTo(context),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: primaryText,
              style: const TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: secondaryText,
              style: TextStyle(color: AppColors.indigo600),
            ),
          ],
        ),
      ),
    );
  }
}