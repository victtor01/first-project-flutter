import 'package:flutter/material.dart';
import 'package:test/common/constants/app_colors.dart';
import 'package:test/features/orders/orders_page.dart';
import 'package:test/features/products/products_page.dart';
import 'package:test/features/tables/tables_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Home Page')),
    const OrdersPage(),
    const TablesPage(),
				const ProductsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 58,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
											top: BorderSide(
												color: Colors.black.withAlpha((255 * 0.1).toInt())
											)
										)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: _currentIndex == 0 ? Icons.home : Icons.home_outlined,
              label: 'Home',
              isSelected: _currentIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            _buildNavItem(
              icon: _currentIndex == 1 ? Icons.bookmark : Icons.bookmark_border,
              label: 'Ordens',
              isSelected: _currentIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            _buildNavItem(
              icon: _currentIndex == 2
                  ? Icons.table_bar
                  : Icons.table_bar_outlined,
              label: 'Mesas',
              isSelected: _currentIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
												  _buildNavItem(
              icon: _currentIndex == 3
                  ? Icons.shopping_bag
                  : Icons.shopping_bag_outlined,
              label: 'Produtos',
              isSelected: _currentIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical:0, horizontal: 10),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: Icon(
                icon,
                key: ValueKey<IconData>(icon),
                color: isSelected ? AppColors.purple600 : Colors.grey,
                size: 25,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.purple600 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
