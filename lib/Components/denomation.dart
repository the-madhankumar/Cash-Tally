import 'package:cash_tally/Context/context.dart';
import 'package:cash_tally/Data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DenominationWidget extends StatefulWidget {
  const DenominationWidget({super.key});

  @override
  State<DenominationWidget> createState() => _DenominationWidgetState();
}

class _DenominationWidgetState extends State<DenominationWidget> {
  final List<String> notes = [
    "2000_note",
    "500_note",
    "200_note",
    "100_note",
    "50_note",
    "20_note",
    "10_note",
    "20_coin",
    "10_coin",
    "5_coin",
    "2_coin",
    "1_coin",
  ];

  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: notes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 18),
        itemBuilder: (context, index) {
          final key = notes[index];
          final denom = context.watch<GrandTotalProvider>().subTotals[key]!;

          final textValue = denom.count == 0 ? "" : denom.count.toString();
          final controller = _controllers.putIfAbsent(
            key,
            () => TextEditingController(),
          );

          if (controller.text != textValue) {
            controller.text = textValue;
          }

          return DenominationRow(
            label: "${denom.value}",
            controller: controller,
            amount: denom.amount.toStringAsFixed(0),
            isNote: denom.isNote,
            onChanged: (text) {
              context.read<GrandTotalProvider>().updateCount(
                key,
                int.tryParse(text) ?? 0,
              );
            },
          );
        },
      ),
    );
  }
}

class DenominationRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String amount;
  final bool isNote;
  final Function(String) onChanged;

  const DenominationRow({
    super.key,
    required this.label,
    required this.controller,
    required this.amount,
    required this.isNote,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 75,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            shape: isNote ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: isNote ? BorderRadius.circular(16) : null,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isNote)
                const Icon(Icons.payments, color: Colors.white, size: 18),
              if (isNote) const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(child: _field(controller, "Count", onChanged)),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              amount == "0" ? "" : amount,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String hint,
    Function(String) onChanged,
  ) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}
