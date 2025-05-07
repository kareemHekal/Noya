import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/presentation/tabs/counsultant/Counsult.dart';
import 'package:noya_app/presentation/tabs/coustom_tab/Coustom.dart';
import 'package:noya_app/presentation/tabs/home/HomeScreen.dart';
import 'package:noya_app/presentation/tabs/packages/Packages.dart';
import 'package:noya_app/presentation/tabs/profile/ProfileScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(onTabSelected: onItemTapped),
      const Packages(),
       CoustomOrder(),
      const Counsult(),
      ProfileScreen(),
    ];
  }

  void onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppStrings.homeLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.inventory_2_outlined),
            label: AppStrings.packagesLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.layers_outlined,),
            label: AppStrings.customLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.phone),
            label: AppStrings.consultLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: AppStrings.profileLabel,
          ),
        ],
      ),
    );
  }
}
