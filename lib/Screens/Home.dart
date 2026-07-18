import 'package:cash_tally/Components/denomation.dart';
import 'package:cash_tally/Components/select_buttons.dart';
import 'package:cash_tally/Components/upi_card.dart';
import 'package:cash_tally/Data/app_colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isCash = true;
  bool isUpi = false;

  void _handleChoice(bool isCashSelected) {
    setState(() {
      isCash = isCashSelected;
      isUpi = !isCashSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectButton(
                context: context,
                data: "Cash",
                backgroundColor: isCash
                    ? AppColors.primaryBlue
                    : AppColors.lightBlue,
                onPressed: () => _handleChoice(true),
              ),

              selectButton(
                context: context,
                data: "UPI",
                backgroundColor: isUpi
                    ? AppColors.primaryBlue
                    : AppColors.lightBlue,
                onPressed: () => _handleChoice(false),
              ),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: (isCash ? DenominationWidget() : UpiCard()),
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }
}
