import 'package:flutter/material.dart';
import 'package:test/core/services/navigation_service.dart';
import 'package:test/ui/components/animated_progress_bar.dart';
import 'package:test/core/services/stores_service.dart';
import 'package:test/ui/features/main/main_page.dart';
import 'package:test/utils/navigation_utils.dart';

class StoreCard extends StatelessWidget {
  final StoreService storesService = StoreService();
  final dynamic store;
  final int index;

  StoreCard({super.key, required this.store, required this.index});

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
    return Row(
      children: [
        Expanded(
          child: AnimatedProgressBar(progress: 0.8), // Exemplo com 80%
        ),
        const SizedBox(width: 10),
        Text(
          "${(0.8 * 100).toInt()}%",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
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
