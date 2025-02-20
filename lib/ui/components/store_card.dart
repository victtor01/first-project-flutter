import 'package:flutter/material.dart';
import 'package:test/common/constants/app_colors.dart';
import 'package:test/core/services/navigation_service.dart';
import 'package:test/ui/components/animated_progress_bar.dart';
import 'package:test/core/services/stores_service.dart';
import 'package:test/ui/features/main/main_page.dart';
import 'package:test/utils/navigation_utils.dart';
import 'package:test/utils/transform_to_real.dart';

class StoreCard extends StatelessWidget {
  final StoreService storesService = StoreService();
  final dynamic store;
  final int revenue;
  final int index;

  double calculateRevenuePercentage(int storeRevenue, int revenue) {
    if (storeRevenue == 0) return 0; // Evita divisão por zero
    return (revenue / storeRevenue) * 100;
  }

  StoreCard(
      {super.key, required this.store, required this.index, this.revenue = 0});

  Future<void> _selectStore() async {
    if (store == null) return;
    final storeId = store["id"];
    final passwordOfStore = store["password"];

    if (passwordOfStore != null) {
					// logic of redirect to password of store
    } else {
      await storesService.selectStore(storeId);
					NavigationService.navigateTo(MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 1000 + (index * 100)),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return GestureDetector(
          onTap: () async {
            await _selectStore();
          },
          child: Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, (1 - value) * 40),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: _customContainerDecoration(),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStoreHeader(),
                      const SizedBox(height: 10),
                      _buildProgressBar(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStoreHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 12,
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
              store["name"] ?? "~blank~",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            if (store["password"] != null)
              Icon(
                Icons.lock,
                size: 14,
                color: Colors.black45,
              ),
          ],
        ),
        Row(
          children: [
            Text(
              store["quantityOfTables"].toString(),
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
    );
  }

  Widget _buildProgressBar() {
    double progress =
        calculateRevenuePercentage(store["revenueGoal"], revenue) / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AnimatedProgressBar(progress: progress),
            ),
            const SizedBox(width: 10),
            Text(
              "${((progress) * 100).toStringAsFixed(2)}%",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black12.withAlpha(10),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formatToReais(revenue),
                style: TextStyle(color: Colors.black45, fontSize: 10),
              ),
              Text(
                "/",
                style: TextStyle(color: Colors.black45),
              ),
              Text(
                formatToReais(store["revenueGoal"]),
                style: TextStyle(color: Colors.black45, fontSize: 10),
              ),
            ],
          ),
        )
      ],
    );
  }

  Decoration _customContainerDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: Colors.black12, width: 1),
      color: Colors.white,
    );
  }
}
