import 'package:flutter/material.dart';
import 'package:mobile_pointsale/common/constants/app_colors.dart';
import 'package:mobile_pointsale/core/interfaces/stores_interfaces/get_informations_response.dart';
import 'package:mobile_pointsale/core/models/store_model.dart';
import 'package:mobile_pointsale/core/services/stores_service.dart';
import 'package:mobile_pointsale/ui/components/store_card.dart';
import 'package:mobile_pointsale/ui/features/splash/splash_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<InformationStore> stores = [];
  InformationStore? informationsOfStore;
  bool isLoading = false;

  final TextStyle textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  final StoreService storeService = StoreService();
  final Border _borderDecorationSelected =
      Border.all(color: AppColors.indigo600, width: 2);

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void stopLoading() => setState(() => isLoading = false);

  Future<void> _getStores() async {
    try {
      final List<InformationStore> all = await storeService.fetchStores();
      setState(() => stores = all);
    } catch (e) {
      _showSnackbar("Erro ao buscar informações: $e");
    } finally {
      stopLoading();
    }
  }

  Future<void> _getStoreInfo() async {
    try {
      InformationStore store = await storeService.getInformations();
      setState(() => informationsOfStore = store);
    } catch (e) {
      _showSnackbar("Erro ao buscar informações: $e");
    } finally {
      stopLoading();
    }
  }

  Widget _buildStoreList() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 60),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              spacing: 2,
              children: [
                Icon(
                  Icons.store,
                  size: 20,
                  color: Colors.black87
                ),
                Text("Minhas lojas", style: textStyle)
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: PageView.builder(
              padEnds: false,
              controller: PageController(viewportFraction: 0.3),
              scrollDirection: Axis.horizontal,
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final dynamic store = stores[index].store;
                final bool currentIsStoreSelected =
                    store.id == informationsOfStore?.store?.id;

                return _buildStoreCard(store, currentIsStoreSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardOfStore() {
    try {
      Store? store = informationsOfStore?.store;

      if (store == null) {
        throw Exception("Erro ao tentar mostrar as informações da loja!");
      }

      double revenue = informationsOfStore?.revenue?.toDouble() ?? 0.0;
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 6,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                spacing: 2,
                children: [
                  Icon(Icons.dashboard, size: 20, color: Colors.black87),
                  Text("Dashboard", style: textStyle),
                ],
              ),
            ),
            StoreCard(store: store, index: 0, revenue: revenue),
          ],
        ),
      );
    } catch (e) {
      return Scaffold(body: Text("$e"));
    }
  }

  Widget _buildStoreCard(dynamic store, bool isSelected) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? _borderDecorationSelected
            : Border.all(color: Colors.black12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _buildStoreCardHeader(),
          _buildStoreCardName(store),
        ],
      ),
    );
  }

  Widget _buildStoreCardHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      height: 60,
    );
  }

  Widget _buildStoreCardName(dynamic store) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        store.name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildAllEmployeeOfStore() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 6,
        children: [
          Row(
            spacing: 5,
            children: [
              Icon(Icons.supervised_user_circle),
              Text("Funcionários", style: textStyle),
            ],
          ),
          Row(
            children: [],
          )
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 110,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.indigo600, AppColors.purple600],
                  stops: [0.9, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 10),
                    blurRadius: 20,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "José Victor Araújo",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: -30,
          left: 15,
          right: 15,
          child: Container(
            width: 70,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.white24,
                    offset: Offset(-10, -10),
                    blurRadius: 20),
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(10, 10),
                    blurRadius: 20),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    informationsOfStore?.store?.name ?? "sem nome",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.indigo600,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Saira",
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    minimumSize: WidgetStateProperty.all(const Size(45, 42)),
                    maximumSize: WidgetStateProperty.all(const Size(45, 42)),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.black12.withAlpha(5),
                    ),
                    elevation: WidgetStateProperty.all(0),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.black38,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _getStores();
    _getStoreInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SplashPage();
    }

    if (informationsOfStore?.store == null) {
      return Scaffold();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildStoreList(),
            const SizedBox(height: 20),
            _buildDashboardOfStore(),
            _buildAllEmployeeOfStore(),
          ],
        ),
      ),
    );
  }
}
