import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test/common/constants/app_colors.dart';
import 'package:test/common/constants/cookies_keys.dart';
import 'package:test/features/home/home_page.dart';
import 'package:test/features/login/login_page.dart';
import 'package:test/features/orders/orders_page.dart';
import 'package:test/features/products/products_page.dart';
import 'package:test/features/tables/tables_page.dart';
import 'package:test/utils/api.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  bool _isLoading = true;

  final List<Widget> _pages = [
    const HomePage(),
    const OrdersPage(),
    const TablesPage(),
    const ProductsPage(),
  ];

  Future<void> _checkCookies() async {
    List<Cookie> cookies = await ApiService.getCookies();

    bool isAuthenticated = cookies.any((cookie) =>
        cookie.name == CookiesKeys.accessToken && cookie.value.isNotEmpty);

    if (!isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkCookies();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 58,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(
                    color: Colors.black.withAlpha((255 * 0.1).toInt())))),
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
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
