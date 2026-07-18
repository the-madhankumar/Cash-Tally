// ignore_for_file: deprecated_member_use

import 'package:cash_tally/Context/context.dart';
import 'package:cash_tally/Data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpiCard extends StatefulWidget {
  const UpiCard({super.key});

  @override
  State<UpiCard> createState() => _UpiCardState();
}

class _UpiCardState extends State<UpiCard> {
  final TextEditingController _cashController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<double> mockCashData = context.watch<GrandTotalProvider>().upiAmounts;

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: mockCashData.length,
          itemBuilder: (context, index) {
            return showCash(
              index: (index + 1).toString(),
              cash: mockCashData[index].toString(),
            );
          },
        ),

        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppColors.lightGray,
                title: const Text("Provide Cash"),
                content: TextField(
                  controller: _cashController,
                  decoration: const InputDecoration(hintText: "Enter amount"),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                    ),
                    onPressed: () {
                      final parsedValue = double.tryParse(_cashController.text);

                      if (parsedValue != null) {
                        context.read<GrandTotalProvider>().updateUpiAmount(
                          parsedValue,
                        );
                        _cashController.clear();
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a valid number"),
                          ),
                        );
                      }
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
            elevation: 0,
            backgroundColor: Colors.transparent,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ],
    );
  }
}

Widget showCash({required String index, required String cash}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    child: Card(
      elevation: 4,
      shadowColor: AppColors.primaryBlue.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(12), // Spacing inside the card
        decoration: BoxDecoration(
          color: Colors.white, // Clean white background
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1), // Soft tint
                shape: BoxShape.circle,
              ),
              child: Text(
                index,
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 20.0),

            Expanded(
              child: Text(
                "Cash Amount",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "₹$cash", // Added currency symbol
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
