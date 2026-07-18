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
    "20_coin",
    "10_note",
    "5_coin",
    "2_coin",
    "1_coin",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: notes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 18),
        itemBuilder: (context, index) {
          String val = notes[index];
          final denom = context.watch<GrandTotalProvider>().subTotals[val]!;

          return DenominationRow(
            label: "${denom.value}",
            countController: TextEditingController(
              text: denom.count == 0 ? '' : denom.count.toString(),
            ),
            amount: denom.amount.toStringAsFixed(0),
            onChanged: (text) {
              int count = int.tryParse(text) ?? 0;
              context.read<GrandTotalProvider>().updateCount(val, count);
            },
            isNote: denom.isNote,
          );
        },
      ),
    );
  }
}

class DenominationRow extends StatelessWidget {
  final String label;
  final TextEditingController countController;
  final String amount;
  final Function(String) onChanged;
  final bool isNote;

  const DenominationRow({
    super.key,
    required this.label,
    required this.countController,
    required this.amount,
    required this.onChanged,
    required this.isNote,
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
        Expanded(child: _field(countController, "Count", true, onChanged)),
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
              amount.isEmpty || amount == "0" ? "" : amount,
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
    bool isEnabled,
    Function(String) onChanged,
  ) {
    return SizedBox(
      height: 50,
      child: TextField(
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
