import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pointsale/common/constants/app_colors.dart';
import 'package:mobile_pointsale/core/interfaces/stores_interfaces/get_informations_response.dart';
import 'package:mobile_pointsale/core/services/navigation_service.dart';
import 'package:mobile_pointsale/core/services/stores_service.dart';
import 'package:mobile_pointsale/ui/components/store_card.dart';
import 'package:mobile_pointsale/ui/features/main/main_page.dart';

class SelectStorePage extends StatefulWidget {
  const SelectStorePage({super.key});

  @override
  State<SelectStorePage> createState() => _SelectStorePageState();
}

class _SelectStorePageState extends State<SelectStorePage> {
  List<InformationStore> stores = [];
  bool isLoading = true;

  final StoreService storeService = StoreService();

  void _getAllStores() async {
    try {
      List<InformationStore> allStores = await storeService.fetchStores();

      setState(() {
        stores = allStores;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _selectStore(String storeId, String? password) async {
    await storeService.selectStore(storeId);
    NavigationService.navigateTo(MainPage());
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
              var store = stores[index].store;
              var revenue = stores[index].revenue?.toDouble() ?? 0.0;

              return Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: StoreCard(
                  store: store,
                  index: index,
                  revenue: revenue,
                  onClick: () => _selectStore(store!.id, store.password),
                ),
              );
            }, childCount: stores.length),
          ),
        ],
      ),
    );
  }
}
