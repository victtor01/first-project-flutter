import 'package:flutter/material.dart';
import 'package:mobile_pointsale/common/constants/app_colors.dart';

void navigateTo(BuildContext context, Widget Function() destination) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => destination()),
  );
}

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
