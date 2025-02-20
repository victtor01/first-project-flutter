import 'package:flutter/material.dart';
import 'package:test/common/constants/app_colors.dart';
import 'package:test/core/services/stores_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> stores = [];
  dynamic selectedStore;
  StoreService storeService = StoreService();

  Future<void> _getStores() async {
    try {
      final List<dynamic> all = await storeService.fetchStores();
      setState(() => stores = all);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getStoreInfo() async {
    try {
      var store = await storeService.getInformations();
      setState(() => selectedStore = store);
    } catch (e) {
      print("houve um erro: $e");
    }
  }

  Widget _showStores() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 60),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Minhas lojas",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
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
                final store = stores[index]?["store"];

                return Container(
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border(bottom: BorderSide(color: Colors.black12)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          store["name"],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                      height: 130,
                      decoration:
                          BoxDecoration(color: AppColors.indigo600, boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 10),
                          blurRadius: 20,
                        )
                      ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "José Victor",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: -30,
                  left: 60,
                  right: 60,
                  child: Container(
                    width: 70,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border:
                            Border.all(
                        color: Colors.black26,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            selectedStore?["store"]?["name"] ?? "sem nome",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.indigo600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: Icon(Icons.edit))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _showStores(),
          ],
        ),
      ),
    );
  }
}
