// ignore_for_file: file_names

import 'package:cash_tally/Context/context.dart';
import 'package:cash_tally/Data/app_colors.dart';
import 'package:cash_tally/Screens/Chart.dart';
import 'package:cash_tally/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [Home(), PieChartSample2()];

    final persistData = context.watch<GrandTotalProvider>();
    final TextEditingController expectedController = TextEditingController();

    final int status = persistData.status;
    final Color statusColor = status == 0
        ? Colors.grey
        : (status > 0 ? Colors.green : Colors.red);
    final IconData statusIcon = status == 0
        ? Icons.adjust
        : (status > 0 ? Icons.arrow_upward : Icons.arrow_downward);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Grand Total",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textWhite,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${persistData.grandTotal}",
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<GrandTotalProvider>().clear();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Reset",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expected",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textWhite,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.lightGray,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: AppColors.lightGray,
                                      title: const Text(
                                        "Provide Expected Amount",
                                      ),
                                      content: TextField(
                                        controller: expectedController,
                                        decoration: const InputDecoration(
                                          hintText: "Enter amount",
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors
                                                .white, // Ensures text is readable on green
                                          ),
                                          onPressed: () {
                                            final text =
                                                expectedController.text;
                                            final parsedValue = double.tryParse(
                                              text,
                                            );

                                            if (parsedValue != null) {
                                              context
                                                  .read<GrandTotalProvider>()
                                                  .updateExpected(parsedValue);
                                              Navigator.pop(context);
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Please enter a valid number",
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: const Text("Set"),
                                        ),
                                      ],
                                    ),
                                  ),
                                },
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.track_changes,
                                        color: Colors.blueAccent,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        persistData.expected.toStringAsFixed(2),
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Icon(
                                            statusIcon,
                                            color: statusColor,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            persistData.difference
                                                .abs()
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: statusColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.all(20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: IndexedStack(index: selectedIndex, children: pages),
              ),
            ),
          ],
        ),
      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
