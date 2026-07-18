// ignore_for_file: deprecated_member_use

import 'package:cash_tally/Data/app_colors.dart';
import 'package:cash_tally/Screens/Chart.dart';
import 'package:cash_tally/Screens/MainPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  final List<Widget> pages = const [MainPage(), PieChartSample2(), Placeholder()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      backgroundColor: AppColors.lightGray,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.9),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            selectedIndex: selectedIndex,
            color: Colors.white70,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.white.withOpacity(0.2),
            padding: const EdgeInsets.all(12),
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.bar_chart, text: "Reports"),
              GButton(icon: Icons.settings, text: "Settings"),
            ],
          ),
        ),
      ),
    );
  }
}
