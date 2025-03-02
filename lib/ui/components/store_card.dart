import 'package:flutter/material.dart';
import 'package:mobile_pointsale/core/models/store_model.dart';
import 'package:mobile_pointsale/ui/components/animated_progress_bar.dart';
import 'package:mobile_pointsale/core/services/stores_service.dart';
import 'package:mobile_pointsale/utils/transform_to_real.dart';

class StoreCard extends StatelessWidget {
  final StoreService storesService = StoreService();
  final Store? store;
  final double revenue;
  final Future<void> Function()? onClick;
  final int index;

  StoreCard(
      {super.key,
      required this.store,
      required this.index,
      this.onClick,
      this.revenue = 0});

  double calculateRevenuePercentage(double storeRevenue, double revenue) {
    if (storeRevenue == 0) return 0;
    return (revenue / storeRevenue) * 100;
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
            if (onClick != null) {
              await onClick!();
            }
          },
          child: Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, (1 - value) * 10),
              child: _buildCardContent(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildStoreHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStoreDetails(),
        _buildStoreTableInfo(),
      ],
    );
  }

  Widget _buildStoreDetails() {
    return Row(
      spacing: 10,
      children: [
        _buildStoreIcon(),
        _buildStoreName(),
        if (store?.password != null) _buildLockIcon(),
      ],
    );
  }

  Widget _buildStoreIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(5),
      ),
      height: 30,
      width: 30,
    );
  }

  Widget _buildStoreName() {
    return Text(
      store?.name ?? "~blank~",
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildLockIcon() {
    return Icon(
      Icons.lock,
      size: 14,
      color: Colors.black45,
    );
  }

  Widget _buildStoreTableInfo() {
    return Row(
      children: [
        Text(
          store?.quantityOfTables?.toString() ?? "0",
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
    );
  }

  Widget _buildProgressBar() {
    double progress =
        calculateRevenuePercentage(store?.revenueGoal ?? 0.0, revenue) / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProgressBarRow(progress),
        _buildRevenueGoalInfo(),
      ],
    );
  }

  Widget _buildProgressBarRow(double progress) {
    return Row(
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
    );
  }

  Widget _buildRevenueGoalInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black12.withAlpha(10),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
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
            formatToReais(store?.revenueGoal ?? 10.0),
            style: TextStyle(color: Colors.black45, fontSize: 10),
          ),
        ],
      ),
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
