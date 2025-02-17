import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/common/constants/app_colors.dart';
import 'package:test/core/services/stores_service.dart';
import 'package:test/ui/components/store_card.dart';

class SelectStorePage extends StatefulWidget {
  const SelectStorePage({super.key});

  @override
  State<SelectStorePage> createState() => _SelectStorePageState();
}

class _SelectStorePageState extends State<SelectStorePage> {
  List<dynamic> stores = [];
  bool isLoading = true;

  void _getAllStores() async {
    StoreService storeService = StoreService();
    List<dynamic> allStores = await storeService.fetchStores();
    setState(() {
      stores = allStores;
						isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllStores();
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
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 6,
          ),
        ),
      );
    }

    if (stores.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 6,
          ),
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
              return StoreCard(store: store, index: index);
            }, childCount: stores.length),
          ),
        ],
      ),
    );
  }
}
