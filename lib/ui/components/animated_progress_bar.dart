import 'package:flutter/material.dart';
import 'package:mobile_pointsale/common/constants/app_colors.dart';

class AnimatedProgressBar extends StatefulWidget {
  final double progress; // De 0 a 1 (exemplo: 0.8 representa 80%)

  const AnimatedProgressBar({super.key, required this.progress});

  @override
  _AnimatedProgressBarState createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar> {
  double animatedWidth = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animatedWidth = widget.progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Opacity(
              opacity: 0.9,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
                height: 8,
                width: constraints.maxWidth * animatedWidth,
                decoration: BoxDecoration(
                  color: AppColors.indigo600,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
