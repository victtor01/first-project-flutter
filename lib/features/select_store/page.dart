import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/common/constants/app_colors.dart';
import 'package:test/features/main/main_page.dart';
import 'package:test/utils/navigation_utils.dart';

class SelectStorePage extends StatelessWidget {
  const SelectStorePage({super.key});

  Future<void> _selectStoreAction() async {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.indigo600,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.indigo600,
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Center(
              child: Text(
                "Organizze",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -5), // sombra suave
                    blurRadius: 20, // desfoque suave
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// GridView.builder(
// 																		shrinkWrap: true,
// 																		physics: NeverScrollableScrollPhysics(),
// 																		padding: EdgeInsets.symmetric(horizontal: 70, vertical: 70),
// 																		gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// 																				crossAxisCount: 2,
// 																				crossAxisSpacing: 30,
// 																				mainAxisSpacing: 30,
// 																				childAspectRatio: 1,
// 																		),
// 																		itemCount: 5,
// 																		itemBuilder: (context, index) {
// 																				return Container(
// 																						padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// 																						decoration: BoxDecoration(
// 																										color: Colors.white,
// 																										borderRadius: BorderRadius.circular(10),
// 																										border: Border.all(color: Colors.black12)),
// 																						width: 50,
// 																						height: 50,
// 																						child: Center(
// 																								child: Text("teste + $index"),
// 																						),
// 																				);
// 																		},
// 																),