import 'package:flutter/material.dart';
import 'package:mobile_pointsale/common/constants/app_colors.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
											
										],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        backgroundColor: AppColors.purple600,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
