import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/presentation/tabs/Counsult.dart';
import 'package:noya_app/presentation/tabs/Coustom.dart';
import 'package:noya_app/presentation/tabs/HomeScreen.dart';
import 'package:noya_app/presentation/tabs/Packages.dart';
import 'package:noya_app/presentation/tabs/ProfileScreen.dart';

class MainScreen extends StatefulWidget {
  final int initialTab;

  MainScreen({super.key, this.initialTab = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          const HomeScreen(),
          const Packages(),
          const CoustomOrder(),
          const Counsult(),
           ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppStrings.homeLabel,
          ),
          BottomNavigationBarItem(
            label: AppStrings.packagesLabel,
            icon: const Icon(Icons.inventory_2_outlined),
          ),
          BottomNavigationBarItem(
            label: AppStrings.customLabel,
            icon: const Icon(Icons.layers_outlined),
          ),
          BottomNavigationBarItem(
            label: AppStrings.consultLabel,
            icon: const Icon(Icons.phone),
          ),
          BottomNavigationBarItem(
            label: AppStrings.profileLabel,
            icon: const Icon(Icons.person_outline),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: ColorManager.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
