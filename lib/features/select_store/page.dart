import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/common/constants/api_constants.dart';
import 'package:test/common/constants/app_colors.dart';
import 'package:test/features/login/login_page.dart';
import 'package:test/utils/api.dart';
import 'package:test/utils/navigation_utils.dart';

class SelectStorePage extends StatefulWidget {
  const SelectStorePage({super.key});

  @override
  State<SelectStorePage> createState() => _SelectStorePageState();
}

class _SelectStorePageState extends State<SelectStorePage> {
  List<dynamic> stores = [];
  bool isLoading = true;

  Future<void> _getAllStores() async {
    final String url = "${ApiConstants.apiURL}/stores/my";

    try {
      var response = await ApiService.dio.get(url);

      setState(() {
        stores = response.data;
        isLoading = false;
      });
    } catch (e) {
      navigateTo(context, () => LoginPage());
      print("ERROR $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllStores();
  }

  Decoration _customContainerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(40),
          offset: Offset(2, 2),
          blurRadius: 20,
        )
      ],
      color: Colors.white,
    );
  }

  Widget _customContainer(dynamic store) {
    return Padding(
      padding: EdgeInsets.only(top: 25, bottom: 0, left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: _customContainerDecoration(),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      store["name"] ?? "nome n disponivel",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      '2',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.table_bar_outlined,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.indigo600,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    if (isLoading) {
      return Scaffold(
        body: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 6,
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.indigo600,
            elevation: 0,
            pinned: false,
            centerTitle: false,
            automaticallyImplyLeading: false,
            expandedHeight: 200,
            flexibleSpace: const FlexibleSpaceBar(
              background: Center(
                child: Text(
                  "Organizze",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              var store = stores[index];
              return _customContainer(store);
            }, childCount: stores.length ?? 0),
          ),
        ],
      ),
    );
  }
}
